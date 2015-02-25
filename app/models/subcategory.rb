class Subcategory < ActiveRecord::Base
  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :category
  has_many :listings
end
