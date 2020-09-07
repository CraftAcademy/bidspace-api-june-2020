RSpec.describe "GET '/api/v1/account/listings" do
  let!(:landlord) { create(:user)}

  let!(:listing) { 2.times { create(:listing, landlord_id: landlord.id) } }

  describe 'landlord successfully get published listings' do
    let(:landlord_credentials) { landlord.create_new_auth_token }
    let(:landlord_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(landlord_credentials) }

    before do
      get '/api/v1/account/listings',
      headers: landlord_headers
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'should return landlord listings' do
      expect(response_json["listings"].count).to eq 2
    end

    it 'should return landlord listings with lead' do
      expect(response_json["listings"].first["lead"]).to eq 'vacant'
    end

    it 'should return landlord listings with lead' do
      expect(response_json["listings"].first["scene"]).to eq 'indoor'
    end
  end
end