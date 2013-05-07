class PagesController < ApplicationController
  def home
  end

  def redirect_to_home
  	redirect_to "/"
  end
end