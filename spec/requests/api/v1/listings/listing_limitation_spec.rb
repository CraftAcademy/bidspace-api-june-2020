RSpec.describe 'POST /api/v1/listings', type: :request do
let!(:landlord) {create(:user)}
let!(:listing) {5.times {create(:listing, landlord: landlord)}}
let!(:landlord_credentials) { landlord.create_new_auth_token }
let!(:landlord_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(landlord_credentials) }

let(:images) {
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
  }

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
             },
           }, headers: landlord_headers
  end

  it 'is expected to return 200 response status' do
      expect(response).to have_http_status 422
  end

  it 'is expect to return error message when creating third listing' do
    expect(response_json['message']).to eq 'Subscribe to create more listing.'
  end
 end
end