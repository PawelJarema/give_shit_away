class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  expose(:categories) { prepare_categories }
  expose(:category_names) { category_names }
  expose(:stan_przedmiotu) { items_state }

  # global variables
  expose(:globals_update_account_information_message) { "Na razie twoje konto nie zawiera wszystkich informacji potrzebnych aby dodawać, wysyłać i zamawiać przedmioty. Kliknij tu aby poprawnie skonfigurować konto." }
  expose(:cities) { ["Gdańsk", "Poznań", "Warszawa"] }
  expose(:strates) { ["Dolnośląskie", "Kujawsko-pomorskie", "Lubelskie", "Lubuskie", "Łódzkie", "Małopolskie", "Mazowieckie", "Opolskie", "Podkarpackie", "Podlaskie", "Pomorskie", "Śląskie", "Świętokrzyskie", "Warmińsko-mazurskie", "Wielkopolskie", "Zachodniopomorskie"] }
  expose(:countries) { ["Polska"] }

  private
	def prepare_categories
	  categories = Category.all 
    categories = seed_categories if categories.count < 1
    categories
	end

	def seed_categories
      categories = category_names
      categories.each do |category|
      	Category.new(name: category).save!
      end
      Category.all
  end

  def category_names
    categories = ['Ubrania', 'Gadżety', 'Płyty CD', 'Gry', 'Obuwie', 'Ozdoby', 'Sprzęt', 'Książki', 'Przybory Szkolne'].sort!
  end

  def items_state
    ['Nowy', 'Bardzo Dobry', 'Dobry', 'Nieuszkodzony', 'Lekkie zużycie', 'Zepsuty']
  end
end
