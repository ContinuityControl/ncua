module NCUA
  module CreditUnion
    class Office < Record
      field :name, 'CU_NAME'
      field :long, 'AddressLongitude'
      field :lat, 'AddressLatitude'
      field :site_name, 'CU_SITENAME'
      field :charter_number, 'CU_NUMBER'
      field :city, 'City'
      field :country, 'Country'
      field :main_office?, 'IsMainOffice'
      field :phone, 'Phone'
      field(:site_functions, 'SiteFunctions') { |value| value.split(";") }
      field :site_id, 'SiteId'
      field :state, 'State'
      field :url, 'URL'
      field :zip, 'Zipcode'
      field(:distance_from_query_address, 'distance') { |value| nil if value < 0 }
      field(:street, 'Street', &:strip)

      def details
        @details ||= Details.new(get_details!)
      end

      private

      def get_details!
        @scraped_attributes ||= Scraper.new(charter_number).scrape!
      end
    end
  end
end
