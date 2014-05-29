class UsersController < ApplicationController

	def update_account_information

	end

	def update
		if current_user.update(user_params)
			flash[:message] = "Gratulacje! Twoje konto jest teraz w pełni aktywne. Aby to sprawdzić, dodaj nowyp rzedmiot"
		else
			flash[:error] = "Przepraszamy, nastąpił błąd serwera. Spróbuj ponownie za godzinę"
		end
		redirect_to :root
	end

	private

	  def user_params
	  	params.require(:user).permit(:name, :surname, :street, :flat, :number, :postal, :city, :strate, :country)
	  end
end