class ApplicationController < ActionController::Base
  protect_from_forgery
  #not working
  @friends = Friend.all
  @hash = Gmaps4rails.build_markers(@friends) do |friend, marker|
	  marker.lat friend.latitude
	  marker.lng friend.longitude
	end
         
end
