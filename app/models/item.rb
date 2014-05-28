class Item < ActiveRecord::Base
	
	has_attached_file :photo, styles: { 
		medium: "300x300>", 
		thumb: "100x100", 
		default_url: "/images/:style/missing.png" 
	}

    validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

	belongs_to :category
	belongs_to :user

	has_many :conversations
    has_many :likes

    # search scopes
    scope :by_title, -> (title) {
    	where("title like ?", "%#{ title }%")
    }

    scope :by_description, -> (text) {
    	where("description like ?", "%#{ text }%")
    }

    scope :by_category, -> (category) {
    	where(category_name: category)
    }

    def has_vote_from?(user) 
    	likes = user.likes
    	likes.each do |like|
    		return true if like.item_id.eql? id
    	end
    	return false
    end
end
