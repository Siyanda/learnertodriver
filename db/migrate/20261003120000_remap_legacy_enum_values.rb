# frozen_string_literal: true

# c8b06bc renumbered these enums (e.g. draft 0 -> 10) without migrating
# existing rows or the column defaults, so old rows read back as nil and new
# rows defaulted to 0, which is not a valid value for most of these enums.
class RemapLegacyEnumValues < ActiveRecord::Migration[8.1]
  STATUS = { 0 => 10, 1 => 20, 2 => 30, 3 => 40, 4 => 50 }.freeze

  REMAPS = [
    { table: :posts,       column: :status, values: STATUS,                                     default: 10 },
    { table: :comments,    column: :status, values: STATUS,                                     default: 10 },
    { table: :quizzes,     column: :status, values: STATUS,                                     default: 10 },
    { table: :pages,       column: :status, values: { 1 => 20, 2 => 10, 3 => 30, 4 => 40 },     default: 0 },
    { table: :tags,        column: :status, values: { 0 => 10, 1 => 20, 2 => 30, 3 => 40 },     default: 20 },
    { table: :questions,   column: :kind,   values: { 0 => 10, 1 => 20, 2 => 30 },              default: 10 },
    { table: :evaluations, column: :status, values: { 0 => 10, 1 => 20, 2 => 30 },              default: 10 },
  ].freeze

  def up
    REMAPS.each do |remap|
      remap_values(remap[:table], remap[:column], remap[:values])
      change_column_default remap[:table], remap[:column], from: 0, to: remap[:default]
    end
  end

  def down
    REMAPS.each do |remap|
      remap_values(remap[:table], remap[:column], remap[:values].invert)
      change_column_default remap[:table], remap[:column], from: remap[:default], to: 0
    end
  end

  private

  def remap_values(table, column, values)
    cases = values.map { |from, to| "WHEN #{Integer(from)} THEN #{Integer(to)}" }.join(' ')

    execute <<~SQL.squish
      UPDATE #{quote_table_name(table)}
      SET #{quote_column_name(column)} = CASE #{quote_column_name(column)} #{cases} END
      WHERE #{quote_column_name(column)} IN (#{values.keys.map { Integer(it) }.join(', ')})
    SQL
  end
end
