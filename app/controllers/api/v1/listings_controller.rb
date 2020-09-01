# frozen_string_literal: true

class Api::V1::ListingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    listings = Listing.all
    render json: { listings: listings }, each_serializer: ListingIndexSerializer
  end

  def show
    listing = Listing.find(params[:id])

    render json: listing, serializer: ListingShowSerializer
  rescue
    render json: { message: 'Unfortunately the listing could not be found' }, status: 422
  end

  def create
    listing = current_user.listings.create(listing_params)
    if listing.persisted?
      render json: { message: 'The listing has been created successfully!' }
    else
      render_error_message(listing.errors)
    end
  rescue => error_message
    render json: { message: error_message }, status: 422
  end

  private

  def listing_params
    params.require(:listing).permit(:category, :lead, :scene, :description, :price, :address)
  end
end
