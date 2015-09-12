module NCUA
  module CreditUnion
    class Scraper
      #This bit is as brittle as glass, as coupled as conjoined twins, and as stinky as bad cheese
      include HTTParty

      base_uri 'http://mapping.ncua.gov'
      def initialize(charter_number)
        @charter_number = charter_number
      end

      def scrape!
        Hash[html_doc.at_css("table#MainContent_newDetails").css("tr").map do |tr|
          if tr.at_css("td.dvHeader") && tr.at_css("td.dvHeader + td")
            [clean_header(tr.at_css("td.dvHeader").text), clean_value(tr.at_css("td.dvHeader + td").text)]
          end
        end]
      end

      private

      def clean_header(text)
        text.gsub(/[,:]/,"").
          gsub("/", " or ").
          gsub(" ","_").
          downcase.
          to_sym
      end

      def clean_value(text)
        text.gsub(/[\n\r]/,"").strip
      end

      def html_doc
        Nokogiri::HTML(request.body)
      end

      def request
        self.class.get(endpoint, query: {
          "ID" => @charter_number
        })
      end

      def endpoint
        '/SingleResult.aspx'
      end
    end
  end
end
