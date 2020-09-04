RSpec.describe 'GET /api/v1/listings', type: :request do
  describe 'successfully get listings' do
    let!(:listing) { 3.times {create(:listing, :with_images, category: 'car park', lead: 'Wide space with safe area', scene: 'indoor')}}

    before do
      get '/api/v1/listings'
    end

    it 'should return a 200 response' do
      expect(response).to have_http_status 200
    end

    it 'should return listings' do
      expect(response_json["listings"].count).to eq 3
    end

    it 'should return the listing lead' do
      expect(response_json["listings"].first["lead"]).to eq 'Wide space with safe area'
    end
    
    it 'should return the listing scene' do
      expect(response_json["listings"].second["scene"]).to eq "indoor"
    end
  end

  describe 'no listing has been added' do
    before do
      get '/api/v1/listings'
    end

    it 'should have no articles on page' do
      expect(response_json["listings"]).to eq []
    end
  end
end