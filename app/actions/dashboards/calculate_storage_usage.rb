# frozen_string_literal: true

class Dashboards::CalculateStorageUsage
  extend ::LightService::Action

  GROWTH_WINDOW    = 30.days
  UNATTACHED_LABEL = 'Unattached'
  RECENT_BYTES_SQL = 'SUM(CASE WHEN active_storage_blobs.created_at >= ? ' \
                     'THEN active_storage_blobs.byte_size ELSE 0 END)'

  StorageModule = Data.define(:label, :bytes, :files, :recent_bytes) do
    def growth
      previous = bytes - recent_bytes
      return if previous.zero?

      (recent_bytes * 100.0 / previous).round(1)
    end
  end

  promises :storage_modules, :storage_bytes, :storage_files

  executed do |ctx|
    modules = totals_by_record_type.map do |record_type, files, bytes, recent_bytes|
      StorageModule.new(label: label_for(record_type), bytes:, files:, recent_bytes:)
    end

    ctx.storage_modules = modules.sort_by { |storage_module| -storage_module.bytes }

    ctx.storage_bytes = ctx.storage_modules.sum(&:bytes)
    ctx.storage_files = ctx.storage_modules.sum(&:files)
  end

  def self.totals_by_record_type
    recent_bytes = ActiveStorage::Blob.sanitize_sql_array([RECENT_BYTES_SQL, GROWTH_WINDOW.ago])

    ActiveStorage::Blob.left_joins(:attachments)
                       .group('active_storage_attachments.record_type')
                       .pluck(
                         'active_storage_attachments.record_type',
                         Arel.sql('COUNT(active_storage_blobs.id)'),
                         Arel.sql('SUM(active_storage_blobs.byte_size)'),
                         Arel.sql(recent_bytes)
                       )
  end
  private_class_method :totals_by_record_type

  def self.label_for(record_type)
    return UNATTACHED_LABEL if record_type.nil?

    model = record_type.safe_constantize
    model ? model.model_name.human.pluralize : record_type
  end
  private_class_method :label_for
end
