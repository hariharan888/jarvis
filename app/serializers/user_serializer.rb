class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :name, :secondary_token
end
