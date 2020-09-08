require 'rails_helper'

RSpec.describe "PUT /api/v1/biddings", type: :request do
  let!(:landlord) { create(:user)}
  let(:landlord_credentials) { landlord.create_new_auth_token }
  let(:landlord_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(landlord_credentials) }

  let!(:subscriber) { create(:user)}

  let!(:listing) do
    create(
      :listing,
      :with_images,
      category: 'Parking Spot',
      lead: 'Big Space for big car',
      scene: 'outdoor', address: 'Vasagatan 1, 40530 Göteborg',
      description: 'Close to a kebab store',
      price: 100,
      landlord_id: landlord.id
    )
  end

  let!(:bid) { create(:bidding, listing_id: listing.id, user_id: subscriber.id)}

  describe "successfully accepted" do
    before do
      put "/api/v1/biddings/#{bid.id}", 
      params: { status: "accepted" },
      headers: landlord_headers 
    end

    it "should return a 200 status" do
      expect(response).to have_http_status 200
    end

    it "should return success message" do
      expect(response_json['message']).to eq "You have accepted this bid!"
    end
  end

  describe "successfully rejected" do
    before do
      put "/api/v1/biddings/#{bid.id}", 
      params: { status: "rejected" },
      headers: landlord_headers 
    end

    it "should return a 200 status" do
      expect(response).to have_http_status 200
    end

    it "should return success message" do
      expect(response_json['message']).to eq "You have rejected this bid!"
    end
  end
end