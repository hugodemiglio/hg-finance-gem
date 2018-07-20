# HG Finance

Welcome to official HG Finance's Ruby Gem!

Now you can simple get finance data (currencies exchange, cryptocurrencies exchanges, brazilian government taxes and stocks markets) from HG Finance API directly on your Ruby Application!

## Available data

### Cryptocurrencies exchange

- Blockchain.info
    - BTC to USD Dollar
- Coinbase
    - BTC to USD Dollar
- BitStamp
    - BTC to USD Dollar
- FoxBit
    - BTC to BRL Brazilian Real
- Mercado Bitcoin
    - BTC to BRL Brazilian Real
- OmniTrade
    - BTC to BRL Brazilian Real  

### Stock markets

- BM&F BOVESPA Sao Paulo, Brazil
- NASDAQ New York City, United States
- CAC 40 Paris, French
- Nikkei 225 Tokyo, Japan

### Currencies exchange

- USD Dollar to BRL Brazilian Real
- EUR Euro to BRL Brazilian Real
- GBP Pound Sterling to BRL Brazilian Real
- ARS Argentine Peso to BRL Brazilian Real
- BTC Bitcoin (blockchain.info) to BRL Brazilian Real

### Taxes

- Brazilian CDI
- Brazilian Selic

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hg-finance'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hg-finance

## Usage

### Configuring

You can configure all of HG Finance params, but not all of them are required.

```ruby
require 'hg/finance'

HG::Finance.setup do |config|
  # You can generate your key on hgbrasil.com/finance
  # Key is required for get some data.
  config.api_key = 'my-key'

  # Set locale for response, default is english, available: pt-br, en
  config.locale = :en

  # Use SSL on request, default and recommended is true
  config.use_ssl = true

  # Coming... If you are using Rails, request can be cached on cache engine
  config.use_rails_cache = true
end

# You also can change setup parameters directly
HG::Finance.api_key = 'my-key'
HG::Finance.locale = 'pt-br'
...
```

### Usage
```ruby
require 'hg/finance'

# You can set any search API parameter here
finance = HG::Finance.get

finance.key_status # => :empty (can be :empty, :valid or :invalid)

finance.taxes
# Will return a HG::Finance::Taxes object
# 16/06 - CDI: 10.14 - SELIC: 10.15 - Fator diário: 1.00038334

finance.taxes.date # => 2017-06-16 00:00:00 -0300
finance.taxes.cdi # => 10.14
finance.taxes.selic # => 10.15
finance.taxes.daily_factor # => 1.00038334

finance.currencies
# Will return an hash with HG::Finance::Currency object, with currencies exchange from BRL
# {"USD"=>Dollar (USD) - Compra: BRL 3.2849 - Venda: BRL 3.2843 - Variação: -0.07, "EUR"=>Eu...

finance.currencies.each do |currency|
  currency.name # => "Dollar"
  currency.iso_code # => "USD"
  currency.source # => "BRL"
  currency.buy # => 3.2849
  currency.sell # => 3.2843
  currency.variation # => -0.07
end

finance.cryptocurrencies
# Will return an hash with HG::Finance::CryptoCurrency object, with currencies exchanges as symbols keys
# {:blockchain_info=>{:btcusd=>Blockchain.info (BTC to USD) - Last: USD 7446.0000905 - Buy: USD 7446.0000905 - Sell

finance.cryptocurrencies[:omnitrade][:btcbrl]
# Will return a HG::Finance::CryptoCurrency object
# => OmniTrade (BTC to BRL) - Last: BRL 28800.0 - Buy: BRL 28500.01 - Sell: BRL 29200.0 - Variation: 0.699

finance.cryptocurrencies.each do |exchange, markets|
  markets.each do |data, market|
    market.exchange # => "OmniTrade"
    market.name # => "Bitcoin"
    market.iso_code # => "BTC"
    market.to_currency # => "BRL"
    market.last # => 28800.0
    market.buy # => 28500.01
    market.sell # => 29200.0
    market.variation # => 0.699
  end
end

finance.stocks
# Will return an hash with HG::Finance::Stock object, with variation of some stock markets
# {"IBOVESPA"=>BM&F BOVESPA - Sao Paulo, Brazil - Variação: 0.63, "NASDAQ"=>NASD...

finance.stocks.each do |stock|
  stock.name # => "BM&F BOVESPA"
  stock.location # => "Sao Paulo, Brazil"
  stock.variation # => 0.63
end

```

### Você é Brasileiro? (Are you Brazilian?)

Se você é brasileiro, basta configurar o idioma para 'pt-br' que todos os dados de data e hora, são convertidos para o padrão brasileiro.

Você pode definir inline ou por bloco:

```ruby
require 'hg/finance'

# Definir por bloco:
HG::Finance.setup do |config|
  config.locale = 'pt-br'
end

# Definir inline:
HG::Finance.locale = 'pt-br'

```

## API Key and Status of Service

Some features like search by geolocation or geoIP requires an API Key.

You can generate your key on official webpage of HG Finance.
There you also find the status of API service.

[hgbrasil.com/finance](http://hgbrasil.com/status/finance/#chaves-de-api)

## Upcoming features

### Gem level

- Improvements on timezone
- Cache with Rails cache engine

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hg-finance.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
