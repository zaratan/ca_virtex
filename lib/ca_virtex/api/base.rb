module CaVirtex
  module API
    class Base
      include HTTParty
      base_uri "http://cavirtex.com/api2"

      CURRENCIES_KEYS = [:BTCCAD,:LTCCAD,:BTCLTC]

      def initialize(api_key, api_secret)
        @api_key = api_key
        @api_secret = api_secret
      end

      private

      def headers(endpoint, params)
        nonce = nonce
        {
          token: @api_key,
          nonce: nonce,
          signature: generate_api_sign(endpoint, nonce, params)
        }
      end

      def nonce
        sprintf("%0.6f", Time.now.to_f).gsub('.', '')
      end

      def generate_api_sign(endpoint, nonce, params)
        data = params.to_alphabeticly_ordered
        Base64.strict_encode64(OpenSSL::HMAC.hexdigest('sha256', @api_secret, nonce + @api_key + endpoint + data))
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
        {currencypair: pair}
      end

      def parse_message(message)
        OpenStruct.new(JSON.parse(message))
      end
    end
  end
end
