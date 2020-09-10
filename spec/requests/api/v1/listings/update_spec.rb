RSpec.describe 'PUT /api/v1/account/listings/:id', type: :request do
  let!(:landlord) { create(:user)}
  let!(:landlord_credentials) { landlord.create_new_auth_token }
  let!(:landlord_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(landlord_credentials) }

  let!(:tenant) { create(:user)}

  let!(:listing) { create(:listing, landlord_id: landlord.id, tenant_id: tenant.id) }

  describe 'landlord can successfully reopen listing' do
    before do
      put "/api/v1/account/listings/#{listing.id}",
      headers: landlord_headers
    end
    
    it 'is expected to return 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return success message' do
      expect(response_json['message']).to eq 'The listing is now available again to the public'
    end

    it 'listing is expected to not have a tenant' do
      listing = Listing.last
      expect(listing.tenant_id).to eq nil
    end
  end

  describe 'unsuccessfully with available listing' do
    let!(:available_listing) { create(:listing, landlord_id: landlord.id) }

    before do
      put "/api/v1/account/listings/#{available_listing.id}",
      headers: landlord_headers
    end
    
    it 'is expected to return 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'is expected to return error message' do
      expect(response_json['message']).to eq 'The listing is already available.'
    end
  end
end