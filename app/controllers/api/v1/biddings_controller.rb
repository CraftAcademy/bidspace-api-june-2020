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
      reject_all_other_bids(bidding)

      bidding.listing.update(tenant_id: bidding.user.id)
      render json: { message: "You have accepted a bid from #{bidding.user.email}"}
    elsif
      params[:status] === "rejected"
      bidding.update(status: "rejected")
      render json: { message: "You have rejected a bid from #{bidding.user.email}"}
    else
      render json: { message: "Something went wrong!"}
    end
  end

  private

  def reject_all_other_bids(bidding)
    biddings = Listing.find_by_id(bidding.listing_id).biddings
    filter_biddings = biddings.select {|bid|bid.id != bidding.id}

    filter_biddings.each do |bid|
      bid.update(status: "rejected")
    end
  end

  def bidding_params
    params.require(:bidding).permit(:bid, :listing_id)
  end

  def check_if_property_is_rented
    if params[:bidding]
      listing = Listing.find(params[:bidding][:listing_id])
    else
      listing = Bidding.find(params[:id]).listing
    end

    if listing.tenant_id != nil
      render json: { message: "This property is already rented." }, status: 422
      return
    end
  end
end
