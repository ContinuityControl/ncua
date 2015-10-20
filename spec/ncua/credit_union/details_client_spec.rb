require 'spec_helper'

describe NCUA::CreditUnion::DetailsClient do
  let(:details_client) { NCUA::CreditUnion::DetailsClient.new }
  describe 'response code handling' do
    let(:valid_charter_number) { 9009 }
    let(:invalid_charter_number) { 234434 }
    let(:good_response) { double("response", code: 200) }
    let(:error_response) { double("response", code: 500) }
    let(:redirect_response) { double("response", code: 302) }
    context 'when the response is 200' do
      it 'does not raise an exception' do
        allow(details_client).to receive(:execute_query).and_return(good_response)

        expect { details_client.get_details(valid_charter_number) }.not_to raise_error(NCUA::CreditUnion::ServerError)
      end
    end

    context 'when the response is 500' do
      it 'raises an NCUA::CreditUnion::ServerError exception' do
        allow(details_client).to receive(:execute_query).and_return(error_response)

        expect { details_client.get_details(valid_charter_number) }.to raise_error(NCUA::CreditUnion::ServerError, "the NCUA returned a 500 error")
      end
    end

    context 'when the response is 300' do
      it 'raises an NCUA::CreditUnion::ServerError with the message "Unexpected Response"' do
        allow(details_client).to receive(:execute_query).and_return(redirect_response)

        expect { details_client.get_details(valid_charter_number) }.to raise_error(NCUA::CreditUnion::ServerError, "Unexpected Response: 302")
      end
    end
  end

  describe 'blank charter numbers' do
    context 'when the charter number is nil' do
      it 'raises an argument error' do
        expect { details_client.get_details(nil) }.to raise_error(ArgumentError)
      end
    end

    context 'when the charter number is an empty string' do
      it 'raises an argument error' do
        expect { details_client.get_details("") }.to raise_error(ArgumentError)
      end
    end

    context 'when the charter number is a whitespace string' do
      it 'raises an argument error' do
        expect { details_client.get_details(" \t   \n   ") }.to raise_error(ArgumentError)
      end
    end
  end
end
