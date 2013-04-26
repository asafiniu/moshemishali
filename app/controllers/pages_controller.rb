class PagesController < ApplicationController
  def home
	puts (0...20).map{ "*" }.join
  	puts "homepage"
  	puts (0...10).map{ "*" }.join	
  end
end