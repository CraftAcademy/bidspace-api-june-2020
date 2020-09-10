class Api::V1::Account::BiddingsController < ApplicationController
  before_action :authenticate_user!

  def index
    biddings = current_user.biddings
    render json: biddings, each_serializer: UserBidsSerializer
  end
end
