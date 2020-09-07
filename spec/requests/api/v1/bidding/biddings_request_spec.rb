# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Biddings', type: :request do
  let!(:user) { create(:user, role: 'registered') }
  let!(:user_credentials) { user.create_new_auth_token }
  let!(:user_headers) { { HTTP_ACCEPT: 'application/json' }.merge!(user_credentials) }

  let!(:listing) { create(:listing) }
  describe 'POST /api/v1/biddings' do
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

  describe 'unsuccessfully with missing params' do
    before do
      post '/api/v1/biddings',
           params: {
             bidding: {
               bid: "",
               listing_id: listing.id
             }
           }, headers: user_headers
    end
    it 'return a 422 status' do
      expect(response).to have_http_status 422
    end
    it 'is expected to return error message' do
      expect(response_json['message']).to eq "Bid can't be blank and Bid is not a number"
    end
  end

  describe 'unsuccessfully with invalid params' do
    before do
      post '/api/v1/biddings',
           params: {
             bidding: {
               bid: "hej",
               listing_id: listing.id
             }
           }, headers: user_headers
    end
    it 'return a 422 status' do
      expect(response).to have_http_status 422
    end
    it 'is expected to return error message' do
      expect(response_json['message']).to eq 'Bid is not a number'
    end
  end

  describe 'unsuccessfully with non registered user' do
    before do
      post '/api/v1/biddings',
           params: {
             bidding: {
               bid: "200",
               listing_id: listing.id
             }
           }
    end
    it 'return a 401 status' do
      expect(response).to have_http_status 401
    end
    it 'is expected to return error message' do
      expect(response_json['errors'].first).to eq 'You need to sign in or sign up before continuing.'
    end
  end

  describe 'User can not bid on their own listing' do
    before do
      post '/api/v1/biddings',
           params: {
             bidding: {
               bid: 200,
               listing_id: listing.id
             }
           }, headers: user_headers
    end
    it 'return a 401 status' do
      expect(response).to have_http_status 401
    end
    it 'is expected to return error message' do
      expect(response_json['errors'].first).to eq 'You could not bid on your own listing'
    end
  end
end
