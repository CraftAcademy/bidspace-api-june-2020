class Listing < ApplicationRecord
  validates_presence_of :category, :lead, :scene, :address, :description, :price
  enum scene: [:indoor, :outdoor]

  geocoded_by :address
  after_validation :geocode

end
