require 'spec_helper'

describe NCUA::CreditUnion::Office do
  let(:response) {
    {
      "AddressLatitude" => 38.367217,
      "AddressLongitude" => -81.689131,
      "CU_NAME" => "SOUTH CHARLESTON EMPLOYEES",
      "CU_SITENAME" => "Credit Union Office",
      "CU_NUMBER" => 16989,
      "City" => "South Charleston",
      "CityPhysical" => "",
      "Country" => "United States",
      "IsMainOffice" => true,
      "Phone" => "3047205600",
      "SiteFunctions" => "Member Services;;",
      "SiteName" => "",
      "SiteId" => 32687,
      "State" => "WV",
      "URL" => "",
      "Zipcode" => "25303",
      "distance" => -1,
      "index" => 0,
      "Street" => "515 3rd Ave Ste 200 "
    }
  }

  let(:credit_union) { NCUA::CreditUnion::Office.new(response) }

  it 'parses data correctly' do
    expect(credit_union.name).to eq("SOUTH CHARLESTON EMPLOYEES")
    expect(credit_union.long).to eq(-81.689131)
    expect(credit_union.lat).to eq(38.367217)
    expect(credit_union.site_name).to eq("Credit Union Office")
    expect(credit_union.charter_number).to eq(16989)
    expect(credit_union.city).to eq('South Charleston')
    expect(credit_union.country).to eq('United States')
    expect(credit_union.main_office?).to be_truthy
    expect(credit_union.phone).to eq('3047205600')
    expect(credit_union.site_functions).to match_array(["Member Services"])
    expect(credit_union.site_id).to eq(32687)
    expect(credit_union.state).to eq('WV')
    expect(credit_union.url).to eq('')
    expect(credit_union.zip).to eq('25303')
  end

  context 'when distance is negative' do
    it '#distance_from_query_address is nil' do
      expect(credit_union.distance_from_query_address).to be_nil
    end
  end

  context 'when there is trailing whitespace in the Street field' do
    it '#street strips the whitespace' do
      expect(credit_union.street).to eq("515 3rd Ave Ste 200")
    end
  end

  context "given a set of site functions" do
      let(:response) {
        { "SiteFunctions" => "Member Services;ATM;" }
      }
    it "parses them into an array" do
      expect(credit_union.site_functions).to match_array(["Member Services","ATM"])
    end
  end
end
