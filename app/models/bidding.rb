class Bidding < ApplicationRecord
  validates :bid, presence: true, numericality: { only_integer: true }
  belongs_to :listing
  belongs_to :user
end
