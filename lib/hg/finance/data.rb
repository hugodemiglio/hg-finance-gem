require 'hg/finance/currency'
require 'hg/finance/taxes'
require 'hg/finance/stock'

module HG
  module Finance

    class Data

      attr_accessor :request, :requested_at, :key_status
      attr_accessor :taxes, :currencies, :stocks

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
          results['currencies'].each do |iso, currency|
            next if iso == 'source'
            @currencies[iso] = Currency.new(to_currency(currency, iso, results['currencies']['source']))
          end

          @stocks = {}
          results['stocks'].each do |code, stock|
            @stocks[code] = Stock.new(to_stock(stock))
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
