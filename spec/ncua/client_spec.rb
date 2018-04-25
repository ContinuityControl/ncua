require 'spec_helper'

describe NCUA::Client do
  describe "parsing keys" do
    context "Given an empty body" do
      it "returns an empty array" do
        mock_response = double(body: "")
        allow(NCUA::Client).to receive(:post) { mock_response }
        response = described_class.new.find_credit_union_by_charter_number("FOO")
        expect(response.keys).to eq([])
      end
    end
  end
end
