class User < ActiveRecord::Base
  require 'devise'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :items
  has_many :wants_to_buy, class_name: 'Conversation', foreign_key: :buyer_id
  has_many :wants_to_sell, class_name: 'Conversation', foreign_key: :seller_id
  has_many :messages
  
end
