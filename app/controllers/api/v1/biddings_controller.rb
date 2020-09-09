# frozen_string_literal: true
class Api::V1::BiddingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]
  before_action :check_if_property_is_rented

  def create
    bidding = current_user.biddings.create(bidding_params)
    if bidding.persisted?
      render json: { message: 'Your bid was successfully sent' }
    else
      render_error_message(bidding.errors)
    end
  rescue StandardError => e
    render json: { message: e }, status: 401
  end

  def update 
    bidding = Bidding.find(params[:id])
    if params[:status] === "accepted"
      bidding.update(status: "accepted")
      bidding.listing.update(tenant_id: bidding.user.id)
      render json: { message: "You have accepted this bid!"}
    elsif
      params[:status] === "rejected"
      bidding.update(status: "rejected")
      render json: { message: "You have rejected this bid!"}
    else
      render json: { message: "Something went wrong!"}
    end
  end

  private

  def bidding_params
    params.require(:bidding).permit(:bid, :listing_id)
  end

  def check_if_property_is_rented
    if params[:listing_id]
      listing = Listing.find(params[:listing_id])
    else
      listing = Bidding.find(params[:id]).listing
    end

    if listing.tenant_id != nil
      render json: { message: "This property is already rented." }, status: 422
      return
    end
  end
end
