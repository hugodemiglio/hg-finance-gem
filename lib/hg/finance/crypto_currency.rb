require 'hg/finance/locale'

module HG
  module Finance

    class CryptoCurrency
      # Public: Exchange
      attr_accessor :exchange

      # Public: Name
      attr_accessor :name

      # Public: ISO code
      attr_accessor :iso_code

      # Public: To currency
      attr_accessor :to_currency

      # Public: Price to buy
      attr_accessor :buy

      # Public: Price to seel
      attr_accessor :sell

      # Public: Last ticker
      attr_accessor :last

      # Public: Last day variation
      attr_accessor :variation

      def initialize(options = {})
        if options.count != 0
          @exchange    = options[:exchange] if options[:exchange]
          @name        = options[:name] if options[:name]
          @iso_code    = options[:iso_code] if options[:iso_code]
          @to_currency = options[:to_currency] if options[:to_currency]
          @buy         = options[:buy].to_f if options[:buy]
          @sell        = options[:sell].to_f if options[:sell]
          @last        = options[:last].to_f if options[:last]
          @variation   = options[:variation].to_f if options[:variation]
        end
      end

      def to_s separator = ' - '
        to_return = []

        to_return << self.exchange.to_s + ' (' + self.iso_code.to_s + ' to ' + self.to_currency + ')'

        to_return << "#{Locale.get_format(:last).to_s.capitalize}: " + "#{self.to_currency} #{self.last}" if self.last
        to_return << "#{Locale.get_format(:buy).to_s.capitalize}: " + "#{self.to_currency} #{self.buy}" if self.buy
        to_return << "#{Locale.get_format(:sell).to_s.capitalize}: " + "#{self.to_currency} #{self.sell}" if self.sell
        to_return << "#{Locale.get_format(:variation).to_s.capitalize}: " + self.variation.to_s if self.variation

        return to_return.join(separator)
      end

      def inspect
        self.to_s
      end
    end

  end
end
