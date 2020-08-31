class ListingShowSerializer < ActiveModel::Serializer
  attributes :id, :category, :lead, :scene, :description, :address, :price
end
