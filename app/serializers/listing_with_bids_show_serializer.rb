class ListingWithBidsShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :category, :lead, :scene, :description, :address, :price, :biddings, :tenant
  attribute :images

  def tenant
    if object.tenant_id
      tenant = User.find(object.tenant_id)
      return tenant
    else
      return nil
    end
  end

  def biddings
    if object.tenant_id == nil
      ActiveModelSerializers::SerializableResource.new(
        object.biddings, 
        each_serializer: BiddingsSerializer,
        adapter: :attributes
      )
    else 
      return nil
    end
  end

  def images
    images_to_return = []
    object.images.each do |image|
      if Rails.env.test?
        images_to_return << {url: rails_blob_url(image)}
      else
        images_to_return << {url: image.service_url(expires_in: 1.hour, disposition: "inline")}
      end
    end
    images_to_return
  end
end