class Category < ActiveRecord::Base
  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :listings
  has_many :subcategories, dependent: :destroy

  
end
