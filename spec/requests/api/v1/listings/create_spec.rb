RSpec.describe "POST /api/v1/listings", type: :request do 

  let!(:landlord) { create(:user)}
  let!(:landlord_credentials) { landlord.create_new_auth_token }
  let!(:landlord_headers) { { HTTP_ACCEPT: 'application/json'}.merge!(landlord_credentials)}

  describe 'successfully with valid params and headers' do 
    before do 
      post '/api/v1/listings',
      params: {
        listing: {
          category: 'car park',
          lead: 'Too good to park',
          scene: 'outdoor',
          address:'Småbrukets backe 30 14158 Huddinge',
          description: "This is an outdoor parking but in safe area",
          price: 150
        }
      }, headers: landlord_headers
    end

    it 'is expected to return 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return success message' do
      expect(response_json['message']).to eq 'The listing has been created successfully!'
    end

    it 'is expected to create listing' do
      listing = Listing.last
      expect(listing.category).to eq 'car park'
    end

    it ' listing is expected to be associated with landlord' do
      expect(landlord.listings.first.lead).to eq 'Too good to park'
    end

    it 'listing is expected to have longitude and latitude' do
      listing = Listing.last
      expect(listing.longitude).to eq 17.9547406
    end
  end
end