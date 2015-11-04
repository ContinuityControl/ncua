module NCUA
  class ClientValidator
    def self.schema_valid?
      base_fields_valid? && list_fields_valid?
    end

    private

    def self.base_fields_valid?
      methods = [:find_credit_union_by_name, :find_credit_union_by_charter_number, :find_credit_union_by_address]
      expected_keys = ['list', 'latitude', 'longitude'].sort
      valid = true

      methods.each do |method_name|
        found_keys = Client.new.send(method_name, "Something Fake").keys.sort
        valid = valid && (found_keys == expected_keys)
      end
      valid
    end

    def self.list_fields_valid?
      expected_keys = ['CU_NAME', 'AddressLongitude', 'AddressLatitude',
                       'CU_SITENAME', 'CU_NUMBER', 'City', 'CityPhysical',
                       'Country', 'index', 'IsMainOffice', 'Phone',
                       'SiteFunctions', 'SiteId', 'SiteName', 'State', 'URL',
                       'Zipcode', 'distance', 'Street'].sort
      found_keys = Client.new.find_credit_union_by_charter_number(42)["list"].first.keys.sort
      # return expected_fields is a subset of found_keys
      return found_keys == expected_keys
    end

  end
end
