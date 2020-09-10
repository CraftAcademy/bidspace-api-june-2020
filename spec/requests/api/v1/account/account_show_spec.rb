RSpec.describe 'GET /api/v1/account/listings', type: :request do
  let!(:landlord) { create(:user)}
  let!(:subscriber) { create(:user)}

  let!(:listing) do
    create(
      :listing,
      :with_images,
      category: 'Parking Spot',
      lead: 'Big Space for big car',
      scene: 'outdoor',
      address: 'Vasagatan 1, 40530 Göteborg',
      description: 'Close to a kebab store',
      price: 100,
      landlord_id: landlord.id
    )
  end
  let!(:bids) { 5.times { create(:bidding, listing_id: listing.id, user_id: subscriber.id)}}

  describe 'successfully gets listing with bids' do
    let(:landlord_credentials) { landlord.create_new_auth_token }
    let(:landlord_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(landlord_credentials) }

    before do
      get "/api/v1/account/listings/#{listing.id}", headers: landlord_headers
    end

    it 'respond with 200 status' do
      expect(response).to have_http_status 200
    end

    it 'shows listing address' do
      expect(response_json['listing']['address']).to eq 'Vasagatan 1, 40530 Göteborg'
    end

    it 'shows listing description' do
      expect(response_json['listing']['description']).to eq 'Close to a kebab store'
    end

    it 'shows listing price' do
      expect(response_json['listing']['price']).to eq 100
    end

    it 'shows bid received' do
      expect(response_json["listing"]["biddings"].count).to eq 5
    end

    it 'shows who placed the bid' do
      expect(response_json["listing"]["biddings"].first["user"]["email"]).to eq subscriber.email
    end

    it 'shows amount bidded' do
      expect(response_json["listing"]["biddings"].first["bid"]).to eq 500
    end

    it 'should not have a tenant' do
      expect(response_json["listing"]["tenant"]).to eq nil
    end
  end

  describe 'successfully gets listing with current tenant' do
    let(:landlord_credentials) { landlord.create_new_auth_token }
    let(:landlord_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(landlord_credentials) }

    let(:tenant) { create(:user)}

    let(:listing) do
      create(
        :listing,
        :with_images,
        category: 'Parking Spot',
        lead: 'Big Space for big car',
        scene: 'outdoor',
        address: 'Vasagatan 1, 40530 Göteborg',
        description: 'Close to a kebab store',
        price: 100,
        landlord_id: landlord.id,
        tenant_id: tenant.id
      )
    end

    before do
      get "/api/v1/account/listings/#{listing.id}",
       headers: landlord_headers
    end

    it 'respond with 200 status' do
      expect(response).to have_http_status 200
    end

    it 'shows listing address' do
      expect(response_json['listing']['address']).to eq 'Vasagatan 1, 40530 Göteborg'
    end

    it 'shows listing description' do
      expect(response_json['listing']['description']).to eq 'Close to a kebab store'
    end

    it 'shows listing price' do
      expect(response_json['listing']['price']).to eq 100
    end

    it 'show tenant email' do
      expect(response_json["listing"]["tenant"]["email"]).to eq tenant.email
    end

    it 'does not show bids' do
      expect(response_json["listing"]["biddings"]).to eq nil
    end
  end

  describe 'unsuccessfully gets listing' do
    before do
      get '/api/v1/listings/10'
    end

    it 'responds with 422 status' do
      expect(response).to have_http_status 422
    end

    it 'responds with error message' do
      expect(response_json['message']).to eq 'Unfortunately the listing could not be found'
    end
  end
end