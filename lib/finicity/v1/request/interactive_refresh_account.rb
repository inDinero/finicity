module Finicity::V1
  module Request
    class InteractiveRefreshAccount
      include ::Finicity::Logger
      extend ::HTTPClient::IncludeClient
      include_http_client do |client|
        client.receive_timeout = 180
        client.cookie_manager = nil
      end

      ##
      # Attributes
      #
      attr_accessor :account_id,
        :customer_id,
        :token

      ##
      # Instance Methods
      #
      def initialize(token, customer_id, account_id)
        @account_id = account_id
        @customer_id = customer_id
        @token = token
      end

      def interactive_refresh_account
        http_client.post(url, nil, headers)
      end

      def headers
        {
          'Finicity-App-Key' => ::Finicity.config.app_key,
          'Finicity-App-Token' => token,
          'Content-Type' => 'application/xml'
        }
      end

      def url
        ::URI.join(
          ::Finicity.config.base_url,
          'aggregation/',
          'v1/',
          'customers/',
          "#{customer_id}/",
          'accounts/',
          "#{account_id}"
        )
      end

    end
  end
end
