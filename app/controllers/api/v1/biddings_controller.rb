# frozen_string_literal: true

class Api::V1::BiddingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def create
    bidding = current_user.biddings.create(bidding_params)
    if bidding.persisted?
      render json: { message: 'Your bid was successfully sent' }
    else
      render_error_message(bidding.errors)
    end
  end

  private

  def bidding_params
    params.require(:bidding).permit(:bid, :listing_id)
  end
end
