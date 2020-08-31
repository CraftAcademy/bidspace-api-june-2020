class Listing < ApplicationRecord
  validates_presence_of :category, :lead, :scene, :height, :description, :price
  enum scene: [:indoor, :outdoor]
end
