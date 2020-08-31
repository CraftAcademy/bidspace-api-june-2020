class ListingIndexSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :category, :description, :scene, :height, :address, :price
end