RSpec.describe 'GET /api/v1/listings', type: :request do
  describe 'successfully get listings' do
    let!(:listing) { 3.times {create(:listing, type: 'car park', description: 'Wide space with safe area', scene: 'indoor', height: 4, address: 'Gothenburg', price: 200)}}
  end

  before do
    get '/api/v1/listings'
  end

it 'should return a 200 response' do
  expect(response).to have_http_status 200
end

it 'should return listings' do
  expect(response_json["listings"].count).to eq 3
end

end