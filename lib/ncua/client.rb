module NCUA
  class Client
    include HTTParty

    base_uri 'http://mapping.ncua.gov'
    format :json
    #debug_output $stderr

    def find_credit_union_by_address(address, radius = 100)
      self.class.get(query_endpoint, query: {
        address: address,
        type: 'address',
        radius: radius.to_s })
    end

    def find_credit_union_by_name(name)
      self.class.get(query_endpoint, query: {
        address: name,
        type: 'cuname' })
    end

    def find_credit_union_by_charter_number(charter_number)
      self.class.get(query_endpoint, query: {
        address: charter_number,
        type: 'cunumber' })
    end

    private

    def query_endpoint
      '/findCUByRadius.aspx'
    end
  end
end
