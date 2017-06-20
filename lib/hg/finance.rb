require 'open-uri'
require 'json'

require 'hg/finance/version'
require 'hg/finance/data'

module HG
  module Finance
    HOST_NAME = '://api.hgbrasil.com/finance'

    class << self
      # API Key
      attr_accessor :api_key

      # Locale
      attr_accessor :locale

      # API Key status
      attr_reader :api_key_status

      # Use SSL to access the API
      attr_accessor :use_ssl

      # Use Rails cache for recieved data (realy recommended)
      attr_accessor :use_rails_cache
    end

    def self.locale
      @locale || :en
    end

    def self.use_ssl
      @use_ssl || true
    end

    def self.setup(&block)
      yield self
    end

    def self.get(options = {})
      process({})
    end

    def self.process params
      params = defaults.merge(params).delete_if{|k,v| v.nil?}

      return HG::Finance::Data.new(params, HOST_NAME, self.use_ssl)
    end

    def self.defaults
      {
        key: self.api_key,
        locale: self.locale,
        format: :json,
        sdk_version: "ruby_f#{HG::Finance::VERSION}"
      }
    end

  end
end
