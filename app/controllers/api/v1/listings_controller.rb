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

  def create
    listing = current_user.listings.create(listing_params)
    # location = Geocoder.search(params[:listing][:address])

    binding.pry
  end


  private 

  def listing_params
    params.require(:listing).permit(:category, :lead, :scene, :description, :price, :address)
  end
end
