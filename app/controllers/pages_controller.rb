class PagesController < ApplicationController
  def home
  	@pending_requests = FriendRequest.where("otherfriend= ?", current_friend)
  	string = ""
  	@hash = Gmaps4rails.build_markers(Friend.all) do |friend, marker|
	    if ((friend.latitude != nil && friend.longitude != nil) && !(friend.latitude == 0 && friend.longitude == 0))
	      marker.lat friend.latitude
	      marker.lng friend.longitude  
	      string = friend.name.concat(" ").concat(friend.surname)
	      marker.infowindow string
    	end
	  end
  end

  def about
  	 @pending_requests = FriendRequest.where("otherfriend= ?", current_friend)
  end
end
