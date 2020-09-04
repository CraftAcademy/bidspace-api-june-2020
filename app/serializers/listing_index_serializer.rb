class ListingIndexSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :category, :lead, :scene
  attribute :image

  def image
    return nil unless object.images.attached?
    if Rails.env.test?
      rails_blob_url(object.images.first)
    else
      object.images.first.service_url(expires_in:1.hour, disposition: 'inline')
    end
  end
end