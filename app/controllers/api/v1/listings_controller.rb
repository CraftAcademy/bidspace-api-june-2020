class Api::V1::ListingsController < ApplicationController
  def index
   listings = Listing.all  
   render json: {listings: listings}, each_serializer: ListingIndexSerializer
  end
end
