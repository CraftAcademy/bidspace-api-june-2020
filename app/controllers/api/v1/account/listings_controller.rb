class Api::V1::Account::ListingsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    listings = current_user.listings
    render json: listings, each_serializer: ListingIndexSerializer
  end

def show
    listing = current_user.listings.find(params[:id])

    render json: listing, serializer: ListingWithBidsShowSerializer
  rescue StandardError => e
    render json: { message: 'Unfortunately the listing could not be found' }, status: 422
  end
  
end