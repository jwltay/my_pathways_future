class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    redirect_to :dashboard if current_user
  end

  def dashboard
  end
end
