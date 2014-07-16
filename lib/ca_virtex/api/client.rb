module CaVirtex
  module API
    class Client
      attr_reader :public, :private

      def initialize(api_key, api_secret)
        @public = CaVirtex::API::Public.new
        @private = CaVirtex::API::Private.new(api_key, api_secret)
      end
    end
  end
end
