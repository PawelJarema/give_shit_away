class ConversationsController < ApplicationController
  expose(:conversation) { get_conversation }
  expose(:wants_to_buy) { current_user.wants_to_buy }
  expose(:wants_to_sell) { current_user.wants_to_sell }
  
  expose(:new_message) { Message.new }
  expose(:messages) { conversation.messages } #.any? ? conversation.messages : {} }
  
  expose(:item) { Item.find(item_id) }

  expose(:buyer_id) { session[:buyer_id] }
  expose(:seller_id) { session[:seller_id] }
  expose(:item_id) { session[:item_id] }

  def inbox
  end

  def index
  end

  # user klika na rzecz, otwiera się okno
  # wysyła pierwszą wiadomość i tworzy konwersację, jeśli takowa nie istnieje
  	# jeśli konwersacja już istnieje, wiadomość dodawana jest do dawnej konwersacji

  # parametry rozpozanwcze current_user, item_user_id, item_id

  def new
  	session[:buyer_id] = current_user.id
  	session[:seller_id] = params[:item_user_id]
  	session[:item_id] = params[:item_id]

    mark_all_messages_as_seen unless conversation.new_record?
  end

  def create
  	conversation.save if conversation.new_record?

  	new_message = Message.new(get_new_message)
  	new_message.user_id = buyer_id
  	new_message.conversation_id = conversation.id

  	new_message.save!

  	render :new
  end

  def close
  end

  def destroy
  end

  private

    def get_params
    	params.permit(:item_user_id, :item_id)
    end

    def get_conversation
      conversation = Conversation.where(buyer_id: current_user.id, seller_id: seller_id, item_id: item_id).last
  	  
  	  unless conversation
  	    conversation = Conversation.new 
  	  	conversation.buyer_id = buyer_id
  	  	conversation.seller_id = seller_id
  	  	conversation.item_id = item_id
  	  end

  	  session[:conversation_id] = conversation.id

  	  conversation
  	end

  	def get_new_message
  		params.require(:new_message).permit(:body)
  	end

    def mark_all_messages_as_seen
      all_messages = conversation.messages.all.where('user_id != ?', current_user.id )
      all_messages.each do |msg|
        #msg.update(seen: true)
      end
    end

end
