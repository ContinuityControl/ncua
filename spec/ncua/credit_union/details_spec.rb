require 'spec_helper'

describe NCUA::CreditUnion::Details do

  let(:attributes) {
    {
      credit_union_name: "WEST VIRGINIA",
      charter_number: "17057",
      credit_union_type: "FCU",
      credit_union_charter_year: "1965",
      charter_state: "",
      region: "2 - Capital",
      field_of_membership_type: "Community credit unions",
      peer_group: "5 - $100,000,000 to less than $500,000,000",
      address: "318 5th Ave",
      city_state_zip_code: "South Charleston, WV 25303-1240",
      country: "United States",
      county: "Kanawha",
      phone: "304-744-7604",
      website: "http://www.wvfcu.org",
      ceo_or_manager: "Nicholas P Arvon"
    }
  }

  let(:details) { NCUA::CreditUnion::Details.new(attributes) }

  context "given simple attributes" do

    it "builds the right fields" do
      expect(details.credit_union_name).to eq("WEST VIRGINIA")
      expect(details.charter_number).to eq("17057")
      expect(details.credit_union_type).to eq("FCU")
      expect(details.credit_union_charter_year).to eq("1965")
      expect(details.charter_state).to eq("")
      expect(details.region).to eq("2 - Capital")
      expect(details.field_of_membership_type).to eq("Community credit unions")
      expect(details.peer_group).to eq("5 - $100,000,000 to less than $500,000,000")
      expect(details.address).to eq("318 5th Ave")
      expect(details.city_state_zip_code).to eq("South Charleston, WV 25303-1240")
      expect(details.country).to eq("United States")
      expect(details.county).to eq("Kanawha")
      expect(details.phone).to eq("304-744-7604")
      expect(details.website).to eq("http://www.wvfcu.org")
      expect(details.ceo_or_manager).to eq("Nicholas P Arvon")
    end
  end

  context "given dates" do
    let(:attributes) {
      {
        current_charter_issue_date: "10/26/1965",
        date_insured: "01/04/1971"
      }
    }

    let(:charter_issue_date) { Date.new(1965, 10, 26) }
    let(:date_insured) { Date.new(1971, 01, 04) }

    it "returns Date objects" do
      expect(details.current_charter_issue_date).to eq(charter_issue_date)
      expect(details.date_insured).to eq(date_insured)
    end
  end

  context "given human readable numbers" do
    let(:attributes) {
      {
        assets: "$153,833,472",
        number_of_members: "9,662"
      }
    }

    let(:assets) { 153833472.00}
    let(:number_of_members) { 9662 }

    it "returns either Fixnums or Floats (for currency)" do
      expect(details.assets).to eq(assets)
      expect(details.number_of_members).to eq(number_of_members)
    end
  end

  context "given Yes/No or Active/Inactive attributes" do
    let(:attributes) {
      {
        corporate_credit_union: "No",
        low_income_designation: "Yes",
        member_of_fhlb: "Yes",
        credit_union_status: "Active"
      }
    }

    it "correctly makes predicate methods" do
      expect(details.corporate_credit_union?).to be false
      expect(details.low_income_designation?).to be true
      expect(details.member_of_fhlb?).to be true
      expect(details.active?).to be true
    end
  end
end
