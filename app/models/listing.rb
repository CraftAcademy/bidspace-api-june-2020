class Listing < ApplicationRecord
  validates_presence_of :category, :lead, :scene, :address, :description, :price
  enum scene: [:indoor, :outdoor]

  geocoded_by :address
  before_create :geocode
  after_validation :check_if_geocoded
  belongs_to :landlord, class_name: "User"

  def check_if_geocoded
  binding.pry
  end

end
