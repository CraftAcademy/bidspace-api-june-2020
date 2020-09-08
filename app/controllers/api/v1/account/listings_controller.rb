class Api::V1::Account::ListingsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    listings = current_user.listings
    render json: listings, each_serializer: ListingIndexSerializer
  end
end