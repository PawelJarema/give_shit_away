class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items
  has_many :wants_to_buy, class_name: 'Conversation', foreign_key: :buyer_id
  has_many :wants_to_sell, class_name: 'Conversation', foreign_key: :seller_id
  
  has_many :messages
  has_many :likes
  
  def conversations
	wants_to_buy + wants_to_sell
  end

  def new_conversation_count(current_user)
  	result = 0;
  	conversations.each do |conversation|
  		result += 1 if conversation.is_new? current_user
  	end

  	result = "" if result < 1;
  	result
  end

  def does_not_validate
    validates = name and surname and street and flat and number and postal and city and strate and country
    not validates
  end

end
