# frozen_string_literal: true

class PhoneNumberType < ActiveModel::Type::Value
  def cast(value)
    case value
    when Hash
      PhoneNumber.new(value[:name], value[:code], value[:number])
    when PhoneNumber
      value
    when nil
      default
    else
      raise ArgumentError, "Invalid PhoneNumber value: #{value.inspect}"
    end
  end

  def serialize(value)
    return if value.nil? || value.blank?

    {
      name:   value.name,
      code:   value.code,
      number: value.number
    }
  end
end
