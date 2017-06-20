require 'hg/finance/locale'

module HG
  module Finance

    class Taxes
      # Public: Date
      attr_accessor :date

      # Public: ISO code
      attr_accessor :cdi

      # Public: Source currency
      attr_accessor :selic

      # Public: Price to buy
      attr_accessor :daily_factor

      def initialize(options = {})
        if options.count != 0
          @date         = process_datetime(options[:date]) if options[:date]
          @cdi          = options[:cdi] if options[:cdi]
          @selic        = options[:selic] if options[:selic]
          @daily_factor = options[:daily_factor] if options[:daily_factor]
        end
      end

      def to_s separator = ' - '
        to_return = []

        to_return << self.date.strftime(Locale.get_format(:short_date)) if self.date && self.date.kind_of?(Time)

        to_return << 'CDI: ' + self.cdi.to_s if self.cdi
        to_return << 'SELIC: ' + self.selic.to_s if self.selic
        to_return << "#{Locale.get_format(:daily_factor).to_s.capitalize}: " + self.daily_factor.to_s if self.daily_factor

        return to_return.join(separator)
      end

      def inspect
        self.to_s
      end

      protected
      def process_datetime date, time = nil
        return Time.now if date.nil?

        return Time.strptime((date + ' ' + (time ? time : '00:00')), Locale.get_format(:datetime))
      end
    end

  end
end
