# frozen_string_literal: true

RSpec.describe 'POST /api/v1/listings', type: :request do
  let!(:landlord) { create(:user) }
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

  describe 'successfully with valid params and headers' do
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

    it 'listing is expected to have image attached' do
      expect(Listing.last.images.attached?).to eq true
    end

    it 'listing is expected to have multiple images' do
      expect(Listing.last.images.count).to eq 2
    end
  end

  describe 'unsuccessfully with ' do
    describe 'non-registered user ' do
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
             }
      end

      it 'is expected to return 401 response status' do
        expect(response).to have_http_status 401
      end

      it 'is expected to return error message' do
        expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
      end
    end

    describe 'with missing params' do
      before do
        post '/api/v1/listings',
             params: {
               listing: {
                 category: '',
                 lead: '',
                 scene: 'outdoor',
                 address: '',
                 description: 'This is an outdoor parking but in safe area',
                 price: 150,
                 images: images
               }
             }, headers: landlord_headers
      end

      it 'is expected to return 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'is expected to return error message' do
        expect(response_json['message']).to eq "Category can't be blank, Lead can't be blank, and Address can't be blank"
      end
    end

    describe 'with no images' do
      before do
        post '/api/v1/listings',
             params: {
               listing: {
                 category: 'car park',
                 lead: 'Too good to park',
                 scene: 'outdoor',
                 address: 'Småbrukets backe 30 14158 Huddinge',
                 description: 'This is an outdoor parking but in safe area',
                 price: 150
               }
             }, headers: landlord_headers
      end

      it 'is expected to return 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'is expected to return error message' do
        expect(response_json['message']).to eq "The image can't be blank"
      end
    end

    describe 'invalid address' do
      before do
        post '/api/v1/listings',
             params: {
               listing: {
                 category: 'car park',
                 lead: 'the great place',
                 scene: 'outdoor',
                 address: 'bdskjbfjdbs743t25873t49223495y',
                 description: 'This is an outdoor parking but in safe area',
                 price: 150
               }
             }, headers: landlord_headers
      end

      it 'is expected to return 422 response status' do
        expect(response).to have_http_status 422
      end

      it 'is expected to return error message' do
        expect(response_json['message']).to eq 'Invalid address'
      end
    end
  end
end
