class Image < ActiveRecord::Base
	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
    validates_attachment_size :photo, :less_than => 1.megabytes

    belongs_to :listing

    def first_image(listing)
      self.where(listing_id: listing)
    end
end
