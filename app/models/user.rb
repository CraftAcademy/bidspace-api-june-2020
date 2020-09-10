# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :listings, foreign_key: "landlord_id", class_name: "Listing"
  has_many :rented_properties, foreign_key: "tenant_id", class_name: "Listing"

  has_many :biddings

  enum role: [:registered, :subscriber]
end
