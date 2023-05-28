# frozen_string_literal: true

module TestPreparations
  class << self
    def log_level(level)
      Rails.logger       = Logger.new($stderr)
      Rails.logger.level = level
    end
  end
end
