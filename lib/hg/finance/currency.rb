require 'hg/finance/locale'

module HG
  module Finance

    class Currency
      # Public: Name
      attr_accessor :name

      # Public: ISO code
      attr_accessor :iso_code

      # Public: Source currency
      attr_accessor :source

      # Public: Price to buy
      attr_accessor :buy

      # Public: Price to seel
      attr_accessor :sell

      # Public: Last day variation
      attr_accessor :variation

      def initialize(options = {})
        if options.count != 0
          @name      = options[:name] if options[:name]
          @iso_code  = options[:iso_code] if options[:iso_code]
          @source    = options[:source] if options[:source]
          @buy       = options[:buy].to_f if options[:buy]
          @sell      = options[:sell].to_f if options[:sell]
          @variation = options[:variation].to_f if options[:variation]
        end
      end

      def to_s separator = ' - '
        to_return = []

        to_return << self.name.to_s + ' (' + self.iso_code.to_s + ')'

        to_return << "#{Locale.get_format(:buy).to_s.capitalize}: " + "#{self.source} #{self.buy}" if self.buy
        to_return << "#{Locale.get_format(:sell).to_s.capitalize}: " + "#{self.source} #{self.sell}" if self.sell
        to_return << "#{Locale.get_format(:variation).to_s.capitalize}: " + self.variation.to_s if self.variation

        return to_return.join(separator)
      end

      def inspect
        self.to_s
      end
    end

  end
end
