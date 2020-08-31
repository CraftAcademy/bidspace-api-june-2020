class ListingShowSerializer < ActiveModel::Serializer
  attributes :id, :category, :lead, :scene, :description, :height, :price
end
