class Api::V1::ListingsController < ApplicationController
  def index
   listings = Listing.all  
   render json: {listings: listings}, each_serializer: ListingIndexSerializer
  end

  def show
    listing = Listing.find(params[:id])

    render json: listing, serializer: ListingShowSerializer
  rescue
    render json: {message: "Unfortunately the listing could not be found"}, status: 422
  end
end
