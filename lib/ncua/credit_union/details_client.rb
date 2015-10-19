module NCUA
  module CreditUnion
    class ServerError < ::StandardError; end
    class DetailsClient
      include HTTParty

      base_uri 'http://mapping.ncua.gov'
      def get_details(charter_number)
        if charter_number.nil?
          raise ArgumentError, "charter number cannot be nil"
        end

        response = execute_query(charter_number)

        case response.code
        when 200...300
          response
        when 500...600
          raise ServerError
        end
      end

      private

      def endpoint
        '/SingleResult.aspx'
      end

      def execute_query(charter_number)
        self.class.get(endpoint, query: {
          "ID" => charter_number
        })
      end
    end
  end
end
