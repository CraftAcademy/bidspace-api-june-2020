class BiddingsSerializer < ActiveModel::Serializer
  attributes :id, :bid
  belongs_to :user, serializer: UserSerializer

end
