require 'hg/finance/crypto_currency'
require 'hg/finance/currency'
require 'hg/finance/taxes'
require 'hg/finance/stock'

module HG
  module Finance

    class Data

      attr_accessor :request, :requested_at, :key_status
      attr_accessor :taxes, :currencies, :cryptocurrencies, :stocks

      def initialize params, host_name, use_ssl = true
        query_params = params.map{|k,v| "#{k.to_s}=#{v.to_s}"}.join('&')
        @request = (use_ssl ? 'https' : 'http') + host_name + '?' + query_params
        @requested_at = Time.now

        request_data = JSON.parse(open(self.request).read)

        if request_data['results']
          results = request_data['results']

          @key_status = (params[:key] ? (request_data['valid_key'] ? :valid : :invalid) : :empty)

          @taxes = Taxes.new(to_taxes(results['taxes'].first)) if @key_status == :valid

          @currencies = {}
          if results.has_key?('currencies')
            results['currencies'].each do |iso, currency|
              next if iso == 'source'
              @currencies[iso] = Currency.new(to_currency(currency, iso, results['currencies']['source']))
            end
          end

          @cryptocurrencies = {}
          if results.has_key?('bitcoin')
            results['bitcoin'].each do |exchange, c|
              @cryptocurrencies[exchange.to_sym] = { "btc#{c['format'][0]}".downcase.to_sym => CryptoCurrency.new(to_cryptocurrency(c, 'Bitcoin', 'BTC')) }
            end
          end

          @stocks = {}
          if results.has_key?('stocks')
            results['stocks'].each do |code, stock|
              @stocks[code] = Stock.new(to_stock(stock))
            end
          end
        end

        return self
      end

      def to_taxes r
        {
          date: r['date'],
          cdi: r['cdi'],
          selic: r['selic'],
          daily_factor: r['daily_factor']
        }
      end

      def to_currency r, iso_code, source
        {
          source: source,
          iso_code: iso_code,
          name: r['name'],
          buy: r['buy'],
          sell: r['sell'],
          variation: r['variation']
        }
      end

      def to_cryptocurrency r, name = 'Bitcoin', iso_code = 'BTC'
        {
          to_currency: r['format'][0],
          exchange: r['name'],
          name: name,
          iso_code: iso_code,
          last: r['last'],
          buy: r['buy'],
          sell: r['sell'],
          variation: r['variation']
        }
      end

      def to_stock r
        {
          name: r['name'],
          location: r['location'],
          variation: r['variation']
        }
      end

    end

  end
end
