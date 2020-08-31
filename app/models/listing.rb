class Listing < ApplicationRecord
  validates_presence_of :category, :lead, :scene
end
