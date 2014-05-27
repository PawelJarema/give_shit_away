class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  expose(:categories) { prepare_categories }

  def setup_global_variables
  end

  private
	def prepare_categories
	  categories = Category.all 
    categories = seed_categories if categories.count < 1
    categories
	end

	def seed_categories
      categories = ['Ubrania', 'Gadżety', 'Płyty CD', 'Gry', 'Obuwie', 'Ozdoby', 'Sprzęt', 'Książki', 'Przybory Szkolne'].sort!
      categories.each do |category|
      	Category.new(name: category).save!
      end
      Categories.all
    end
end
