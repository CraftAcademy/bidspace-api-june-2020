# frozen_string_literal: true
class Api::V1::BiddingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update]

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
    else
      render json: { message: "Something went wrong"}
    end
  end

  private

  def bidding_params
    params.require(:bidding).permit(:bid, :listing_id)
  end
end
