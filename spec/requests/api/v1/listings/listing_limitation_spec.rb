# frozen_string_literal: true

RSpec.describe 'POST /api/v1/listings', type: :request do
  let!(:landlord) { create(:user, role: 'registered') }
  let!(:listing) { 5.times { create(:listing, landlord: landlord) } }
  let!(:landlord_credentials) { landlord.create_new_auth_token }
  let!(:landlord_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(landlord_credentials) }

  let(:images) do
    [
      {
        type: 'application/json',
        encoder: 'iphone_picture',
        data: 'AEwughvcvjdkshdhdcdcgWEgvcdhhd',
        extension: 'jpg'
      },
      {
        type: 'application/json',
        encoder: 'parking_picture',
        data: 'DfhgxhsxsvttfusxSDDDJhcdcdc',
        extension: 'jpg'
      }
    ]
  end

  describe 'Reg user can only successfully create two listing' do
    before do
      post '/api/v1/listings',
           params: {
             listing: {
               category: 'car park',
               lead: 'Too good to park',
               scene: 'outdoor',
               address: 'Småbrukets backe 30 14158 Huddinge',
               description: 'This is an outdoor parking but in safe area',
               price: 150,
               images: images
             }
           }, headers: landlord_headers
    end

    it 'is expected to return 422 response status' do
      expect(response).to have_http_status 422
    end

    it 'is expect to return error message when creating third listing' do
      expect(response_json['message']).to eq 'Subscribe to create more listing.'
    end
  end

  describe 'subscriber can successfully create more then two listings' do
    let(:landlord) { create(:user, role: 'subscriber') }
    let(:landlord_credentials) { landlord.create_new_auth_token }
    let(:landlord_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(landlord_credentials) }
    let!(:listing) { 5.times { create(:listing, landlord: landlord) } }

    before do
      post '/api/v1/listings',
           params: {
             listing: {
               category: 'car park',
               lead: 'Too good to park',
               scene: 'outdoor',
               address: 'Småbrukets backe 30 14158 Huddinge',
               description: 'This is an outdoor parking but in safe area',
               price: 150,
               images: images
             }
           }, headers: landlord_headers
    end

    it 'is expected to return 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return success message' do
      expect(response_json['message']).to eq 'The listing has been created successfully!'
    end

    it 'is expected to have six listings created' do
      expect(Listing.all.count).to eq 6
    end
  end
end
