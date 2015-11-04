require 'spec_helper'
describe NCUA::ClientValidator do
  let(:client_double) { double("NCUA::Client") }
  before :each do
    allow(NCUA::Client).to receive(:new) { client_double }
  end

  describe '.schema_valid?' do
    describe '.base_fields_valid? private method' do
      context 'when the base fields are valid' do
        let(:expected_response) { {'list' => "values",
                                   'latitude' => "don't",
                                   'longitude' => "matter"} }
        before do
          allow(client_double).to receive(:find_credit_union_by_name) { expected_response }
          allow(client_double).to receive(:find_credit_union_by_address) { expected_response }
          allow(client_double).to receive(:find_credit_union_by_charter_number) { expected_response }
        end

        it 'returns true' do
          expect(NCUA::ClientValidator.send(:base_fields_valid?)).to be_truthy
        end
      end

      context 'when the fields are invalid' do
        context 'because a key has changed' do
          let(:unexpected_response) { {'dog' => "values",
                                       'latitude' => "don't",
                                       'longitude' => "matter"} }

          before do
            allow(client_double).to receive(:find_credit_union_by_name) { unexpected_response }
            allow(client_double).to receive(:find_credit_union_by_address) { unexpected_response }
            allow(client_double).to receive(:find_credit_union_by_charter_number) { unexpected_response }
          end

          it 'returns false' do
            expect(NCUA::ClientValidator.send(:base_fields_valid?)).to be_falsey
          end
        end

        context 'because there is an extra key' do
          let(:unexpected_response) { {'list' => "values",
                                     'latitude' => "don't",
                                     'dog' => "don't",
                                     'longitude' => "matter"} }

          before do
            allow(client_double).to receive(:find_credit_union_by_name) { unexpected_response }
            allow(client_double).to receive(:find_credit_union_by_address) { unexpected_response }
            allow(client_double).to receive(:find_credit_union_by_charter_number) { unexpected_response }
          end

          it 'returns false' do
            expect(NCUA::ClientValidator.send(:base_fields_valid?)).to be_falsey
          end
        end

        context 'because there is not an expected key' do
          let(:unexpected_response) { {'list' => "values",
                                     'longitude' => "matter"} }
          before do
            allow(client_double).to receive(:find_credit_union_by_name) { unexpected_response }
            allow(client_double).to receive(:find_credit_union_by_address) { unexpected_response }
            allow(client_double).to receive(:find_credit_union_by_charter_number) { unexpected_response }
          end

          it 'returns false' do
            expect(NCUA::ClientValidator.send(:base_fields_valid?)).to be_falsey
          end
        end
      end
    end

    describe '.list_fields_valid? private method' do
      context 'all fields are valid' do
        let(:expected_response) { {'list' =>
                                   [{
                                     'CU_NAME'=> 'something',
                                     'AddressLongitude'=> 'something',
                                     'AddressLatitude'=> 'something',
                                     'CU_SITENAME'=> 'something',
                                     'CU_NUMBER'=> 'something',
                                     'City'=> 'something',
                                     'CityPhysical'=> 'something',
                                     'Country'=> 'something',
                                     'index' => 'something',
                                     'IsMainOffice'=> 'something',
                                     'Phone'=> 'something',
                                     'SiteFunctions'=> 'something',
                                     'SiteId'=> 'something',
                                     'SiteName'=> 'something',
                                     'State'=> 'something',
                                     'URL'=> 'something',
                                     'Zipcode'=> 'something',
                                     'distance'=> 'something',
                                     'Street'=> 'something',
                                   }],
                                   'latitude' => "don't",
                                   'longitude' => "matter"} }

        before do
          allow(client_double).to receive(:find_credit_union_by_charter_number) { expected_response }
        end
        it 'returns true' do
          expect(NCUA::ClientValidator.send(:list_fields_valid?)).to be_truthy
        end
      end

      context 'some fields are missing' do
        let(:unexpected_response) { {'list' =>
                                   [{
                                     'CU_NAME'=> 'something',
                                     'AddressLongitude'=> 'something',
                                     #'AddressLatitude'=> 'something',
                                     'CU_SITENAME'=> 'something',
                                     #'CU_NUMBER'=> 'something',
                                     'City'=> 'something',
                                     'CityPhysical'=> 'something',
                                     'Country'=> 'something',
                                     'index'=> 'something',
                                     'IsMainOffice'=> 'something',
                                     'Phone'=> 'something',
                                     #'SiteFunctions'=> 'something',
                                     'SiteId'=> 'something',
                                     'SiteName'=> 'something',
                                     'State'=> 'something',
                                     'URL'=> 'something',
                                     'Zipcode'=> 'something',
                                     'distance'=> 'something',
                                     'Street'=> 'something',
                                   }],
                                   'latitude' => "don't",
                                   'longitude' => "matter"} }

        before do
          allow(client_double).to receive(:find_credit_union_by_charter_number) { unexpected_response }
        end
        it 'returns false' do
          expect(NCUA::ClientValidator.send(:list_fields_valid?)).to be_falsey
        end
      end

      context 'omg extra fields' do
        let(:unexpected_response) { {'list' =>
                                   [{
                                     'CU_NAME'=> 'something',
                                     'AddressLongitude'=> 'something',
                                     'AddressLatitude'=> 'something',
                                     'CU_SITENAME'=> 'something',
                                     'CU_NUMBER'=> 'something',
                                     'City'=> 'something',
                                     'CityPhysical'=> 'something',
                                     'Country'=> 'something',
                                     'index'=> 'something',
                                     'IsMainOffice'=> 'something',
                                     'Phone'=> 'something',
                                     'SiteFunctions'=> 'something',
                                     'SiteId'=> 'something',
                                     'SiteName'=> 'something',
                                     'State'=> 'something',
                                     'URL'=> 'something',
                                     'Zipcode'=> 'something',
                                     'distance'=> 'something',
                                     'Street'=> 'something',
                                     'NumberOfPugs' => 'never enough',
                                     'NumberOfcats' => 'evil',
                                   }],
                                   'latitude' => "don't",
                                   'longitude' => "matter"} }

        before do
          allow(client_double).to receive(:find_credit_union_by_charter_number) { unexpected_response }
        end
        it 'returns false' do
          expect(NCUA::ClientValidator.send(:list_fields_valid?)).to be_falsey
        end
      end

      context 'omg different fields' do
        let(:unexpected_response) { {'list' =>
                                   [{
                                     'CU_NAME'=> 'something',
                                     'AddressLongitude'=> 'something',
                                     'AddressLatitude'=> 'something',
                                     'CU_SITENAME'=> 'something',
                                     'CU_NUMBER'=> 'something',
                                     'City'=> 'something',
                                     'CityPhysical'=> 'something',
                                     'Country'=> 'something',
                                     'index'=> 'something',
                                     'IsMainOffice'=> 'something',
                                     'Phone'=> 'something',
                                     'SiteFunctions'=> 'something',
                                     'SiteId'=> 'something',
                                     'SiteName'=> 'something',
                                     'State'=> 'something',
                                     'URL'=> 'something',
                                     'Zipcode'=> 'something',
                                     'distance'=> 'something',
                                     'JumpStreet'=> 'something', #21
                                   }],
                                   'latitude' => "don't",
                                   'longitude' => "matter"} }

        before do
          allow(client_double).to receive(:find_credit_union_by_charter_number) { unexpected_response }
        end
        it 'returns false' do
          expect(NCUA::ClientValidator.send(:list_fields_valid?)).to be_falsey
        end
      end
    end
  end
end
