class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    if user_signed_in?
      @images = current_user.images
    end
  end
  
end
