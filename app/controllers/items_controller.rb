class ItemsController < ApplicationController
  expose(:items) { search_for_items }
  expose(:new_item) { Item.new }

  def index
  end

  def new
  end

  def create
    item = Item.new(item_params)
    item.user = current_user
    item.category = Category.find_by_name(item_params[:category])
    
    if item.save!
      flash[:notice] = "Gratulacje! Dodałeś przedmiot."
    else
      flase[:error] = "Operacja dodawania przedmiotu nie powiodła się."
    end
    redirect_to :root
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private 

    def search_for_items
      Item.all
    end 

    def item_params
      p = params.require(:item).permit(:title, :category_name, :state, :price, :description, :photo)
      p[:price] = p[:price].to_f
      p
    end

end
