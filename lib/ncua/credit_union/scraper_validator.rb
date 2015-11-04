module NCUA
  module CreditUnion
    class ScraperValidator
      def schema_valid?
        has_a_table?  &&
        has_correctly_formatted_key_value_rows? &&
        has_correct_keys?
      end

      private

      def has_a_table?
        !html_doc.at_css('table#MainContent_newDetails').nil?
      end

      def has_correctly_formatted_key_value_rows?
        key_value_rows.all? { |tr|
          key_value_row?(tr.css("td")) || sub_header_row?(tr.css("td"))
        }
      end

      def has_correct_keys?
        found_keys = key_value_rows.map { |tr| tr.at_css('td.dvHeader') }.compact.map(&:text)
        expected_keys = ["Credit Union Name:", "Charter Number:", "Credit Union Type:",
                         "Credit Union Status:", "Corporate Credit Union:",
                         "Credit Union Charter Year:", "Current Charter Issue Date:",
                         "Date Insured:", "Charter State:", "Region:",
                         "Field of Membership Type:", "Low Income Designation:",
                         "Member of FHLB:", "Assets:", "Peer Group:", "Number of Members:",
                         "Address:", "City, State Zip code:", "Country:", "County:", "Phone:",
                         "Website:", "CEO/Manager:"]
        found_keys == expected_keys
      end

      def key_value_row?(tr_cells)
        tr_cells.count == 2 && tr_cells.first[:class] == 'dvHeader'
      end

      def sub_header_row?(tr_cells)
        tr_cells.count == 1 && tr_cells.first[:class] == 'subheader'
      end

      def request
        @request ||= DetailsClient.new.get_details(42)
      end

      def html_doc
        @html_doc ||= Nokogiri::HTML(request.body)
      end

      def key_value_rows
        @key_value_rows ||= html_doc.at_css("table#MainContent_newDetails").css("tr")
      end
    end
  end
end
