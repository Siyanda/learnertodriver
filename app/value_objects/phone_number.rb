# frozen_string_literal: true

PhoneNumber = Data.define(:name, :code, :number) do
  def full_number
    "#{code}#{number}"
  end

  def formatted_number
    "#{code} #{number.gsub(/(\d{3})(\d{3})(\d{3})/, '\1 \2 \3')}"
  end

  def blank?
    [name, code, number].all?(&:blank?)
  end

  def to_s
    "#{name}: #{full_number}"
  end
end
