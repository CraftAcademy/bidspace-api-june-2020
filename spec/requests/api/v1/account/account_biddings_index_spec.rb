RSpec.describe "GET '/api/v1/account/biddings" do
  let!(:landlord) { create(:user)}
  let!(:subscriber) { create(:user)}
  let!(:other_user) { create(:user)}

  let!(:listings) { 2.times { create(:listing, landlord_id: landlord.id) }} 

  let!(:first_bid) { create(:bidding, listing_id: Listing.first.id, user_id: subscriber.id) }
  let!(:second_bid) { create(:bidding, listing_id: Listing.last.id, user_id: subscriber.id, status: "accepted") }
  let!(:other_bid) { create(:bidding, listing_id: Listing.first.id, user_id: other_user.id) }

  describe 'potential tenant successfully gets listings which they have bid on' do
    let(:subscriber_credentials) { subscriber.create_new_auth_token }
    let(:subscriber_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(subscriber_credentials) }

    before do
      get '/api/v1/account/biddings',
      headers: subscriber_headers
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'should return potential tenants listings which they have bid on' do
      expect(response_json["biddings"].count).to eq 2
    end

    it 'should return what listing the bid was made for' do
      expect(response_json["biddings"].first["listing"]["id"]).to eq Listing.first.id
    end

    it 'should return bid with an amount' do
      expect(response_json["biddings"].first["bid"]).to eq 500
    end

    it 'should return bid with the status' do
      expect(response_json["biddings"].last["status"]).to eq "accepted"
    end
  end

  describe 'non-registered users unsuccessfully get their biddings' do
    before do
      get '/api/v1/account/biddings'
    end

    it "should return a 401 status" do 
      expect(response).to have_http_status 401
    end

    it "is expected to return error message" do 
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end
end