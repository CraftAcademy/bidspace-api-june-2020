RSpec.describe "GET '/api/v1/account/biddings" do
  let!(:landlord) { create(:user)}
  let!(:subscriber) { create(:user)}
  let!(:other_user) { create(:user)}

  let!(:listing_1) { create(:listing, lead: "The first lead", scene: "outdoor", landlord_id: landlord.id) }
  let!(:listing_2) { create(:listing, lead: "The first lead", scene: "outdoor", landlord_id: landlord.id) }
  let!(:bid_1) { create(:bidding, listing_id: listing_1.id, user_id: subscriber.id) }
  let!(:bid_2) { create(:bidding, listing_id: listing_2.id, user_id: subscriber.id) }

  let!(:other_bid) { create(:bidding, listing_id: listing_1.id, user_id: other_user.id) }

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

    it 'should return bid with an amount' do
      expect(response_json["biddings"].first["bid"]).to eq 500
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