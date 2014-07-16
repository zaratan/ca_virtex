module CaVirtex
  module API
    class Public < Base
      def initialize
      end

      def orderbook(params = {})
        params.slice!(:order_currency, :payment_currency, :count)
        response = parse_message(orderbook_call(params).body)
        parse_orders(response, params[:count])
      end

      private

      def orderbook_call(order_currency: :BTC, payment_currency: :CAD, count: 10)
        query = {currencypair: construct_currency_pair(order_currency, payment_currency)}
        self.class.get("/orderbook.json", query: query)
      end

      def parse_orders(orders, count) 
        count ||= 1000
        orders.orderbook= OpenStruct.new(orders.orderbook)
        orders.orderbook.bids = parse_order(orders.orderbook.bids).first(count) 
        orders.orderbook.asks = parse_order(orders.orderbook.asks).first(count) 
        orders
      end

      def parse_order(order_list)
        order_list.map do |e|
          Struct.new(:price, :amount).new(e[0], e[1])
        end
      end
    end
  end
end
