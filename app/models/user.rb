class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>", :profile => "69x69>" }, :default_url => "default_avatar.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :username, presence: true, format: { with: /\A[a-zA-Z0-9]+\Z/ }

  GENDER_SELECT = ['Male', 'Female', 'Rather not say']
  ROLE_SELECT = ['Member', 'Admin']

  has_many :listings, dependent: :destroy

  def age(birthday)
    now = Time.now.utc.to_date
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end
end
