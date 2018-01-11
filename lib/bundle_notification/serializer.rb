# frozen_string_literal: true

module BundleNotification
  module Serializer
    class << self
      delegate :dump, to: :serializer

      def load(data)
        serializer.load(data) if data
      end

      def serializer
        BundleNotification.config.serializer || YAML
      end
    end
  end
end
