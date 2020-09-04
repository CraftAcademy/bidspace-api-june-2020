# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Biddings', type: :request do
  describe 'POST /api/v1/biddings' do
    let!(:user) { create(:user, role: 'registered') }
    let!(:user_credentials) { user.create_new_auth_token }
    let!(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

    let!(:listing) { create(:listing) }

    before do
      post '/api/v1/biddings',
           params: {
             bidding: {
               bid: 200,
               listing_id: listing.id
             }
           }, headers: user_headers
    end

    it 'is expected to return 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return success message' do
      expect(response_json['message']).to eq 'Your bid was successfully sent'
    end
  end
end
