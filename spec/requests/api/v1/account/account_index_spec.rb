RSpec.describe "GET '/api/v1/account/listings" do
  let!(:landlord) { create(:user)}
  let!(:subscriber) { create(:user)}

  let!(:landlord_listings) { 2.times { create(:listing, lead: "The first lead", scene: "outdoor", landlord_id: landlord.id) } }
  let!(:other_listings) { 2.times { create(:listing, landlord_id: subscriber.id) } }

  describe 'landlord successfully get their published listings' do
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
      expect(response_json["listings"].first["lead"]).to eq 'The first lead'
    end

    it 'should return landlord listings with scene' do
      expect(response_json["listings"].last["scene"]).to eq 'outdoor'
    end
  end


  describe 'non-registered users unsuccessfully gets listings' do
    before do
      get '/api/v1/account/listings'
    end

    it "should return a 401 status" do 
      expect(response).to have_http_status 401
    end

    it "is expected to return error message" do 
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end