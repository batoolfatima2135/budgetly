class HomeController < ApplicationController
  before_action :check_user_logged_in, only: [:index]
  def index; end

  def check_user_logged_in
    return unless user_signed_in?

    redirect_to categories_path
  end
end
