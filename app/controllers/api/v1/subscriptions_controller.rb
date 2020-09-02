class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_is_subscriber?
  before_action :check_stripe_token
  
  def create
    binding.pry
  end
end
