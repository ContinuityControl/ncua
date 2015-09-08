require 'spec_helper'

describe NCUA::ArgParser do
  let(:parser) { NCUA::ArgParser }

  context "when the arguments are empty" do
    let(:options) { { } }

    it "raises an ArgumentError" do
      expect {
        parser.parse(options)
      }.to raise_error(NCUA::NoArgumentError)
    end
  end

  context "when there is more than one key" do
    let(:options) {
      { address: "123 Main St. Springfield, MO",
        name: "First FCU" }
    }

    it "raises an ArgumentError" do
      expect {
        parser.parse(options)
      }.to raise_error(NCUA::TooManyArgumentsError)
    end
  end

  context "when there is an invalid key" do
    let(:options) {
      { asset_size: "HUGE" }
    }

    it "raises an ArgumentError" do
      expect {
        parser.parse(options)
      }.to raise_error(NCUA::InvalidArgumentError)
    end
  end
end

