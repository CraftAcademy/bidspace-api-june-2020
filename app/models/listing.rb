class Listing < ApplicationRecord
  validates_presence_of :category, :lead, :scene, :address, :description, :price
  enum scene: [:indoor, :outdoor]

  geocoded_by :address
  
  belongs_to :landlord, class_name: "User"

  before_save :geocode
  after_save :check_if_geocoded

  def check_if_geocoded
    unless self.geocoded?
      self.destroy
      raise StandardError.new "Invalid address"
    end
  end
end
