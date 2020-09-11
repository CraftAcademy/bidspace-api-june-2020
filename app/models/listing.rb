class Listing < ApplicationRecord
  validates_presence_of :category, :lead, :scene, :address, :description, :price
  enum scene: [:indoor, :outdoor]

  has_many_attached :images
  has_many :biddings

  geocoded_by :address
  
  belongs_to :landlord, class_name: "User"
  belongs_to :tenant, class_name: "User", optional: true

  before_save :geocode
  before_create :check_if_user_is_subscriber
  after_save :check_if_geocoded

  def check_if_geocoded
    unless self.geocoded?
      self.destroy
      raise StandardError.new "Invalid address"
    end
  end

  def check_if_user_is_subscriber
    
    user = User.find(landlord_id)
    if user.registered? and user.listings.count == 2
      raise StandardError.new "Subscribe to create more listings."
    end
  end
end