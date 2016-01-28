class Restaurant < ActiveRecord::Base
  has_attached_file :photo,
	                  :styles => {original: "1200x900>",medium: "100x67>"},
	                  :default_url => "/images/:style/missing.png"
	validates_attachment :photo,
	  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"]},
	  size: {less_than: 1.megabytes}
  
  validates :website, presence: true
	
	belongs_to :map
	belongs_to :author, class_name: "User", foreign_key: :user_id
	has_many :likes
	
	# Tell geocoder which method returns geocodable address
	geocoded_by :location
	after_validation :geocode
	
	# The validation to ensure if you are the author or not
	def editable_by?(user)
		user && user == author
	end
	
	def liked_by?(user,restaurant)
    Like.where(:user_id => user.id, :restaurant_id => restaurant.id).present?
  end
end
