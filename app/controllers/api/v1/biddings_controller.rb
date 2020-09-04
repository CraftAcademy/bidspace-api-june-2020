class Api::V1::BiddingsController < ApplicationController
  def create
      # listing = Listing.where(params[:listing_id])
      bidding = current_user.biddings.create(bidding_params)
      render json: {message: "Your bid was successfully sent"}
  end




  private

  def bidding_params
  params.require(:bidding).permit(:bid, :listing_id)
  end
end
