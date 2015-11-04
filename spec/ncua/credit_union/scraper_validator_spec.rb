require 'spec_helper'

describe NCUA::CreditUnion::ScraperValidator do
  describe '#schema_valid?' do
    let(:details_client_double)  { double("NCUA::CreditUnion::DetailsClient") }
    let(:valid_response_body) { %q(
      <table id="MainContent_newDetails" summary="Details">
        <tbody>
          <tr> <td class="dvHeader">Credit Union Name:</td> <td> FD COMMUNITY </td> </tr>
          <tr> <td class="dvHeader">Charter Number:</td> <td> 42 </td> </tr>
          <tr> <td class="dvHeader">Credit Union Type:</td> <td> FCU </td> </tr>
          <tr> <td class="dvHeader">Credit Union Status:</td> <td> Active </td> </tr>
          <tr> <td class="dvHeader">Corporate Credit Union:</td> <td> No </td> </tr>
          <tr> <td class="dvHeader">Credit Union Charter Year:</td> <td> 1934 </td> </tr>
          <tr> <td class="dvHeader">Current Charter Issue Date:</td> <td> 01/01/1934 </td> </tr>
          <tr> <td class="dvHeader">Date Insured:</td> <td> 01/19/1971 </td> </tr>
          <tr> <td class="dvHeader">Charter State:</td> <td> </td> </tr>
          <tr> <td class="dvHeader">Region:</td> <td> 1 - Albany </td> </tr>
          <tr> <td class="dvHeader">Field of Membership Type:</td> <td> Community credit unions </td> </tr>
          <tr> <td class="dvHeader">Low Income Designation:</td> <td> No </td> </tr>
          <tr> <td class="dvHeader">Member of FHLB:</td> <td> No </td> </tr>
          <tr> <td class="dvHeader">Assets:</td> <td> $65,876,457 </td> </tr>
          <tr> <td class="dvHeader">Peer Group:</td> <td> 4 - $50,000,000 to less than $100,000,000 </td> </tr>
          <tr> <td class="dvHeader">Number of Members:</td> <td> 7,595 </td> </tr>
          <tr> <td align="right" class="subheader"><h2>Main Office</h2></td> </tr>
          <tr> <td class="dvHeader">Address:</td> <td> 601 Watertown Ave </td> </tr>
          <tr> <td class="dvHeader">City, State Zip code:</td> <td> Waterbury, CT 06708 </td> </tr>
          <tr> <td class="dvHeader">Country:</td> <td> United States </td> </tr>
          <tr> <td class="dvHeader">County:</td> <td> New Haven </td> </tr>
          <tr> <td class="dvHeader">Phone:</td> <td> 203-753-9201 </td> </tr>
          <tr> <td class="dvHeader">Website:</td> <td> <a href="http://www.fdcommunityfcu.org" target="_blank">http://www.fdcommunityfcu.org</a> </td> </tr>
          <tr> <td class="dvHeader">CEO/Manager:</td> <td> Michael C Kinne </td> </tr>
        </tbody>
      </table> ) }

    before :each do
      allow(NCUA::CreditUnion::DetailsClient).to receive(:new) {details_client_double}
    end

    context 'given a valid response' do
      before do
        allow(details_client_double).to receive(:get_details) {
          double("response", body: valid_response_body )
        }
      end

      let(:scraper_validator) { NCUA::CreditUnion::ScraperValidator.new }
      it 'returns true' do
        expect(scraper_validator.schema_valid?).to be_truthy
      end
    end

    context 'given an invalid response' do
      context 'expected key missing' do
        let(:invalid_response_body) { %q(
          <table id="MainContent_newDetails" summary="Details">
            <tbody>
              <tr> <td class="dvHeader">Credit Union Name:</td> <td> FD COMMUNITY </td> </tr>
              <tr> <td class="dvHeader">Charter Number:</td> <td> 42 </td> </tr>
              <tr> <td class="dvHeader">Credit Union Type:</td> <td> FCU </td> </tr>
              <tr> <td class="dvHeader">Credit Union Status:</td> <td> Active </td> </tr>
              <!-- <tr> <td class="dvHeader">Corporate Credit Union:</td> <td> No </td> </tr> -->
              <tr> <td class="dvHeader">Credit Union Charter Year:</td> <td> 1934 </td> </tr>
              <tr> <td class="dvHeader">Current Charter Issue Date:</td> <td> 01/01/1934 </td> </tr>
              <tr> <td class="dvHeader">Date Insured:</td> <td> 01/19/1971 </td> </tr>
              <tr> <td class="dvHeader">Charter State:</td> <td> </td> </tr>
              <tr> <td class="dvHeader">Region:</td> <td> 1 - Albany </td> </tr>
              <tr> <td class="dvHeader">Field of Membership Type:</td> <td> Community credit unions </td> </tr>
              <tr> <td class="dvHeader">Low Income Designation:</td> <td> No </td> </tr>
              <tr> <td class="dvHeader">Member of FHLB:</td> <td> No </td> </tr>
              <tr> <td class="dvHeader">Assets:</td> <td> $65,876,457 </td> </tr>
              <tr> <td class="dvHeader">Peer Group:</td> <td> 4 - $50,000,000 to less than $100,000,000 </td> </tr>
              <tr> <td class="dvHeader">Number of Members:</td> <td> 7,595 </td> </tr>
              <tr> <td align="right" class="subheader"><h2>Main Office</h2></td> </tr>
              <tr> <td class="dvHeader">Address:</td> <td> 601 Watertown Ave </td> </tr>
              <tr> <td class="dvHeader">City, State Zip code:</td> <td> Waterbury, CT 06708 </td> </tr>
              <tr> <td class="dvHeader">Country:</td> <td> United States </td> </tr>
              <tr> <td class="dvHeader">County:</td> <td> New Haven </td> </tr>
              <tr> <td class="dvHeader">Phone:</td> <td> 203-753-9201 </td> </tr>
              <tr> <td class="dvHeader">Website:</td> <td> <a href="http://www.fdcommunityfcu.org" target="_blank">http://www.fdcommunityfcu.org</a> </td> </tr>
              <tr> <td class="dvHeader">CEO/Manager:</td> <td> Michael C Kinne </td> </tr>
            </tbody>
          </table> ) }

        before do
          allow(details_client_double).to receive(:get_details) {
            double("response", body: invalid_response_body )
          }
        end

        let(:scraper_validator) { NCUA::CreditUnion::ScraperValidator.new }
        it 'returns false' do
          expect(scraper_validator.schema_valid?).to be_falsey
        end
      end

      context 'unexpected key present' do
        let(:invalid_response_body) { %q(
          <table id="MainContent_newDetails" summary="Details">
            <tbody>
              <tr> <td class="dvHeader">Credit Union Name:</td> <td> FD COMMUNITY </td> </tr>
              <tr> <td class="dvHeader">Charter Number:</td> <td> 42 </td> </tr>
              <tr> <td class="dvHeader">Credit Union Type:</td> <td> FCU </td> </tr>
              <tr> <td class="dvHeader">Credit Union Status:</td> <td> Active </td> </tr>
              <tr> <td class="dvHeader">Corporate Credit Union:</td> <td> No </td> </tr>
              <tr> <td class="dvHeader">THE SPANISH INQUISITION</td> <td> No </td> </tr>
              <tr> <td class="dvHeader">Credit Union Charter Year:</td> <td> 1934 </td> </tr>
              <tr> <td class="dvHeader">Current Charter Issue Date:</td> <td> 01/01/1934 </td> </tr>
              <tr> <td class="dvHeader">Date Insured:</td> <td> 01/19/1971 </td> </tr>
              <tr> <td class="dvHeader">Charter State:</td> <td> </td> </tr>
              <tr> <td class="dvHeader">Region:</td> <td> 1 - Albany </td> </tr>
              <tr> <td class="dvHeader">Field of Membership Type:</td> <td> Community credit unions </td> </tr>
              <tr> <td class="dvHeader">Low Income Designation:</td> <td> No </td> </tr>
              <tr> <td class="dvHeader">Member of FHLB:</td> <td> No </td> </tr>
              <tr> <td class="dvHeader">Assets:</td> <td> $65,876,457 </td> </tr>
              <tr> <td class="dvHeader">Peer Group:</td> <td> 4 - $50,000,000 to less than $100,000,000 </td> </tr>
              <tr> <td class="dvHeader">Number of Members:</td> <td> 7,595 </td> </tr>
              <tr> <td align="right" class="subheader"><h2>Main Office</h2></td> </tr>
              <tr> <td class="dvHeader">Address:</td> <td> 601 Watertown Ave </td> </tr>
              <tr> <td class="dvHeader">City, State Zip code:</td> <td> Waterbury, CT 06708 </td> </tr>
              <tr> <td class="dvHeader">Country:</td> <td> United States </td> </tr>
              <tr> <td class="dvHeader">County:</td> <td> New Haven </td> </tr>
              <tr> <td class="dvHeader">Phone:</td> <td> 203-753-9201 </td> </tr>
              <tr> <td class="dvHeader">Website:</td> <td> <a href="http://www.fdcommunityfcu.org" target="_blank">http://www.fdcommunityfcu.org</a> </td> </tr>
              <tr> <td class="dvHeader">CEO/Manager:</td> <td> Michael C Kinne </td> </tr>
            </tbody>
          </table> ) }

        before do
          allow(details_client_double).to receive(:get_details) {
            double("response", body: invalid_response_body )
          }
        end

        let(:scraper_validator) { NCUA::CreditUnion::ScraperValidator.new }
        it 'returns false' do
          expect(scraper_validator.schema_valid?).to be_falsey
        end
      end

      context 'no table with the correct id' do
        let(:invalid_response_body) { %q( <table id="foo" summary="Details"> </table> ) }

        before do
          allow(details_client_double).to receive(:get_details) {
            double("response", body: invalid_response_body )
          }
        end

        let(:scraper_validator) { NCUA::CreditUnion::ScraperValidator.new }
        it 'returns false' do
          expect(scraper_validator.schema_valid?).to be_falsey
        end
      end

      context 'no rows with the correct header class' do
        let(:invalid_response_body) { %q( <table id="MainContent_newDetails" summary="Details"> </table> ) }

        before do
          allow(details_client_double).to receive(:get_details) {
            double("response", body: invalid_response_body )
          }
        end

        let(:scraper_validator) { NCUA::CreditUnion::ScraperValidator.new }
        it 'returns false' do
          expect(scraper_validator.schema_valid?).to be_falsey
        end
      end
    end
  end
end
