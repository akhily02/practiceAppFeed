class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @session = user_signed_in?
    @user = current_user
  end

end