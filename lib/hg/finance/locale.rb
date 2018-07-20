module HG
  module Finance

    class Locale

      @formats = {
        en: {
          date: '%Y-%m-%d',
          short_date: '%m-%d',
          datetime: '%Y-%m-%d %H:%M',
          buy: :buy,
          sell: :sell,
          variation: :variation,
          last: :last,
          daily_factor: 'daily factor'
        },
        :'pt-br' => {
          date: '%d/%m/%Y',
          short_date: '%d/%m',
          datetime: '%d/%m/%Y %H:%M',
          buy: :compra,
          sell: :venda,
          variation: 'variação',
          last: 'último',
          daily_factor: 'fator diário'
        }
      }

      def self.get_format item
        Finance.locale = :en unless @formats.has_key?(Finance.locale.to_sym)

        return @formats[Finance.locale.to_sym][item]
      end

    end

  end
end
