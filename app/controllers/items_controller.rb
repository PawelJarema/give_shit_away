class ItemsController < ApplicationController
  expose(:items) { search_for_items }
  expose(:new_item) { get_item }

  def like
    unless Item.find(params[:item_id]).has_vote_from? current_user
      like = Like.create!(user_id: current_user.id, item_id: params[:item_id])
    end
    render :index
  end

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
    new_item = Item.find(params[:id])
  end

  def update
    item = Item.new(item_params)

    if item.save!
      flash[:notice] = "Zauktualizowano dane przedmiotu"
    else
      flase[:error] = "Operacja aktualizacji przedmiotu nie powiodła się."
    end

    item.update!
    redirect_to :root
  end

  def destroy
  end

  private 

    def search_for_items
      if search_params != nil
        title = search_params[:query]
        search = ItemSearch.new(title: title, category: params[:category]).results  + ItemSearch.new(description: title, category: params[:category]).results
      else
        search = Item.where(category: params[:category])
      end

      search
    end 

    def get_item
      id = params[:id]
      new_item = id != nil ? Item.find(id) : Item.new
    end

    def item_params
      p = params.require(:item).permit(:title, :category_name, :state, :price, :description, :photo)
      p[:price] = p[:price].to_f
      p
    end

    def search_params
      params.require(:search).permit(:query) if params[:search]
    end

end
