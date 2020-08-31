RSpec.describe "GET /api/v1/listings", type: :request do
  let!(:listing) { create(:listing, category: 'car park', lead: 'Wide space with safe area', scene: 'indoor', height: 4, description: "This is the best place to park your car", price: 200)}

  describe 'successfully gets listing' do
    before do 
      get "/api/v1/listings/#{listing.id}" 
    end 

  it 'respond with 200 status' do
    expect(response_json).to have_http_status 200
  end

  it 'shows listing height' do
    expect(response_json['listing']['height']).to eq 4
  end

  it 'shows listing description' do
    expect(response_json['listing']['description']).to eq "This is the best place to park your car"
  end

  it 'shows listing price'do
    expect(response_json['listing']['price']).to eq 200
  end
  end
end