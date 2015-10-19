require 'spec_helper'

describe NCUA::CreditUnion::DetailsClient do
  let(:details_client) { NCUA::CreditUnion::DetailsClient.new }
  describe 'response code handling' do
    let(:valid_charter_number) { 9009 }
    let(:invalid_charter_number) { 234434 }
    let(:good_response) { double("response", code: 200) }
    let(:error_response) { double("response", code: 500) }
    context 'when the response is 200' do
      it 'does not raise an exception' do
        allow(details_client).to receive(:execute_query).and_return(good_response)

        expect { details_client.get_details(valid_charter_number) }.not_to raise_error(NCUA::CreditUnion::ServerError)
      end
    end

    context 'when the response is 500' do
      it 'raises an NCUA::CreditUnion::RecordNotFound exception' do
        allow(details_client).to receive(:execute_query).and_return(error_response)

        expect { details_client.get_details(valid_charter_number) }.to raise_error(NCUA::CreditUnion::ServerError)
      end
    end
  end

  describe 'nil charter numbers' do
    context 'when the charter number is nil' do
      it 'raises an argument error' do
        expect { details_client.get_details(nil) }.to raise_error(ArgumentError)
      end
    end
  end
end
