module NCUA
  class Client
    include HTTParty

    base_uri 'http://mapping.ncua.gov'
    format :json
    #debug_output $stderr

    def find_credit_union_by_address(address, radius = 100)
      parse_response(self.class.post(query_endpoint, query: {
        address: address,
        type: 'address',
        radius: radius.to_s }))
    end

    def find_credit_union_by_name(name)
      parse_response(self.class.post(query_endpoint, query: {
        address: name,
        type: 'cuname' }))
    end

    def find_credit_union_by_charter_number(charter_number)
      parse_response(self.class.post(query_endpoint, query: {
        radius: 100,
        address: charter_number,
        type: 'cunumber' }))
    end

    private

    def query_endpoint
      '/findCUByRadius.aspx'
    end

    def parse_response(response)
      JSON.parse(response.body)
    rescue JSON::ParserError
      {}
    end
  end
end
