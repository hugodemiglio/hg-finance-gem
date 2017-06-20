require 'hg/finance/locale'

module HG
  module Finance

    class Stock
      # Public: Name
      attr_accessor :name

      # Public: Market Identifier Code
      # attr_accessor :mic

      # Public: Location
      attr_accessor :location

      # Public: Last util day variation
      attr_accessor :variation

      def initialize(options = {})
        if options.count != 0
          @name      = options[:name] if options[:name]
          # @mic       = options[:mic] if options[:mic]
          @location  = options[:location] if options[:location]
          @variation = options[:variation] if options[:variation]
        end
      end

      def to_s separator = ' - '
        to_return = []

        to_return << "#{self.name} - #{self.location}" if self.name && self.location
        to_return << "#{Locale.get_format(:variation).to_s.capitalize}: " + self.variation.to_s if self.variation

        return to_return.join(separator)
      end

      def inspect
        self.to_s
      end
    end

  end
end
