#require 'hashlib'
#require 'hmac'
module CaVirtex
  module API
    class Base
      include HTTParty
      base_uri "https://cavirtex.com/api2"

      CURRENCIES_KEYS = [:BTCCAD,:LTCCAD,:BTCLTC]

      def initialize(api_key, api_secret)
        @api_key = api_key
        @api_secret = api_secret
      end

      private

      def headers(endpoint, params = {})
        current_nonce = nonce
        {
          token: @api_key,
          nonce: current_nonce,
          signature: generate_api_sign(endpoint, current_nonce, params)
        }
      end

      def nonce
        sprintf("%0.6f", Time.now.to_f).gsub('.', '')
      end

      def generate_api_sign(endpoint, nonce, params)
        data = params.to_alphabeticly_ordered || ""
        digest = OpenSSL::Digest.new('sha256')
        OpenSSL::HMAC.hexdigest(digest, @api_secret, nonce + @api_key + '/api2' + endpoint + data)
      end

      def construct_currency_pair(currency_1, currency_2)
        pair = unless (currency_1 == :BTC || currency_2 == :BTC)
                 "LTCCAD"
               else
                 if (currency_1 == :CAD || currency_2 == :CAD)
                   "BTCCAD"
                 else
                   "BTCLTC"
                 end
               end
        pair
      end

      def parse_message(message)
        result = OpenStruct.new(JSON.parse(message))
        throw Error.new(result.message) if result.status != "ok"
        result
      end
    end
  end
end
