class Bidding < ApplicationRecord
  validates :bid, presence: true, numericality: { only_integer: true }
  belongs_to :listing
  belongs_to :user
  before_create :check_if_user_is_landlord
  before_update :check_if_property_is_rented
  enum status: [:pending, :accepted, :rejected]

  def check_if_user_is_landlord
    listing = Listing.find(listing_id)   
    user = User.find(user_id)
    if user_id == listing.landlord_id
      raise StandardError.new 'You could not bid on your own listing'
    end 
  end

  def check_if_property_is_rented
    listing = Listing.find(listing_id)
    if listing.tenant_id != nil
      raise StandardError.new "This property is already rented."
    end
  end
end
