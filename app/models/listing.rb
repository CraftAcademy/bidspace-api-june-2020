class Listing < ApplicationRecord
  validates_presence_of :category, :lead, :scene, :address, :description, :price
  enum scene: [:indoor, :outdoor]
end
