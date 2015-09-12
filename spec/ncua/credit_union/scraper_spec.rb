require 'spec_helper'

describe NCUA::CreditUnion::Scraper do
  context "given messy html" do
    let(:html) { %q(
  <table id="MainContent_newDetails">
    <tbody><tr>
      <td class="dvHeader">Credit Union Name:</td>
      <td>
                                  WEST VIRGINIA
                          </td>
    </tr>
    <tr>
      <td class="dvHeader">City, State Zip code:</td>
      <td>
                                  South Charleston, WV 25303-1240
                          </td>
    </tr>
    <tr>
      <td class="dvHeader">CEO/Manager:</td>
      <td>
                                  Nicholas P Arvon
                          </td>
    </tr>
  </tbody></table>
                 ) }

    let(:scraper) { NCUA::CreditUnion::Scraper.new(62599) }

    it "strips whitespace from values" do
      allow(scraper).to receive(:html_doc).and_return(Nokogiri::HTML(html))

      expect(scraper.scrape!.values.first).to eq("WEST VIRGINIA")
    end

    it "downcases and symbolizes headers" do
      allow(scraper).to receive(:html_doc).and_return(Nokogiri::HTML(html))

      expect(scraper.scrape!.keys.first).to eq(:credit_union_name)
    end

    it "strips colons and commas from headers" do
      allow(scraper).to receive(:html_doc).and_return(Nokogiri::HTML(html))

      expect(scraper.scrape!.keys[1]).to eq(:city_state_zip_code)
    end

    it "replaces slashes with 'or' in headers" do
      allow(scraper).to receive(:html_doc).and_return(Nokogiri::HTML(html))

      expect(scraper.scrape!.keys.last).to eq(:ceo_or_manager)
    end
  end
end
