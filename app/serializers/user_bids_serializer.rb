class UserBidsSerializer < ActiveModel::Serializer
  attributes :id, :bid
  belongs_to :listing, serializer: ListingIndexSerializer
end
