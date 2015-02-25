class State < ActiveRecord::Base
  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :listings

def self.to_csv
  CSV.generate do |csv|
    csv << column_names
    all.each do |state|
      csv << state.attributes.values_at(*column_names)
    end
  end
end

end
