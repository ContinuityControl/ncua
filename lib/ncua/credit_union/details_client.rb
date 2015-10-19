module NCUA
  module CreditUnion
    class DetailsClient
      include HTTParty

      base_uri 'http://mapping.ncua.gov'
      def get_details(charter_number)
        response = execute_query(charter_number)
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
    class RecordNotFoundError < StandardError; end
  end
end
