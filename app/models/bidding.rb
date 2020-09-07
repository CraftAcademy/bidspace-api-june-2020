class Bidding < ApplicationRecord
  validates :bid, presence: true, numericality: { only_integer: true }
  belongs_to :listing
  belongs_to :user
  before_create :check_if_user_is_landlord

  def check_if_user_is_landlord
    user = 
    binding.pry
  end
end
