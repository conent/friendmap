class PagesController < ApplicationController
  def home
  	@pending_requests = FriendRequest.where("otherfriend= ?", current_friend)
  	string = ""
  	#TODO: change false into true
    friendsOnline= Friend.where("isonline = ? and latitude != ? and longitude != ?", "false", 0, 0)
  	@hash = Gmaps4rails.build_markers(friendsOnline) do |friend, marker|
	    if ((friend.latitude != nil && friend.longitude != nil) && !(friend.latitude == 0 && friend.longitude == 0))
	      marker.lat friend.latitude
	      marker.lng friend.longitude  
        marker.picture({
          "url" => "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/original/mapmarker.png",
          "width" => 36,
          "height" => 36
        })
	      string = "<p>".concat(friend.name).concat(" ").concat(friend.surname).concat("</p> <p>").concat(friend.address).concat("</p>")
	      marker.infowindow string
    	end
	  end
  end

  def about
  	 @pending_requests = FriendRequest.where("otherfriend= ?", current_friend)
  end
end
