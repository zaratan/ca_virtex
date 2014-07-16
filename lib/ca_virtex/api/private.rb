module CaVirtex
  module API
    class Private < Base
      def balance
        parse_message(balance_call)
      end

      def order(currency_from: :CAD, currency_to: :BTC, mode: "buy", amount: "0" ,price: "0")
        parse_message(
          order_call(
            construct_currency_pair(currency_from, currency_to),
            mode,
            amount,
            price
          )
        )
      end

      private

      def balance_call
        endpoint = '/user/balance.json'
        query = headers(endpoint)
        self.class.post(endpoint, body: query)
      end

      def order_call(currency_pair, mode, amount, price)
        endpoint = '/user/order.json'
        params={
          currencypair: currency_pair,
          mode: mode,
          amount: amount,
          price: price
        }
        query = headers(endpoint, params)
        self.class.post(endpoint, body: query.merge(params))
      end
    end
  end
end
