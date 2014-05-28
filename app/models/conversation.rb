class Conversation < ActiveRecord::Base

	belongs_to :seller, class_name: 'User', foreign_key: :seller_id
	belongs_to :buyer, class_name: 'User', foreign_key: :buyer_id
	belongs_to :item
	has_many :messages
	
	scope :open, -> { where(concluded: false) }
	scope :closed, -> { where(concluded: true) }
	scope :item_sent, -> { where(item_sent: true) }

	def is_new?(current_user)
		messages.each do |message|
			return true if not message.seen and not message.user.eql? current_user
		end

		false
	end

	def new_message_count(current_user)
		result = 0
		messages.each do |message|
			result += 1 unless message.seen and message.user.eql? current_user
		end

		result
	end

end
