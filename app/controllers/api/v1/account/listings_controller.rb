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

  def update
    listing = current_user.listings.find(params[:id])
    render json: listing, serializer: ListingWithBidsShowSerializer
    binding.pry
    if biddings.accepted?
      render json: { message: 'You have accepted this bid!' }
    elsif biddings.rejected?
      render json: { message: 'You have rejected this bid!' }
    else
      render json: { message: 'Something went wrong' }, status: 422
    end
  end
end