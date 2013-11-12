class PagesController < ApplicationController
  def home
  	@pending_requests = FriendRequest.where("otherfriend= ?", current_friend)
  	string = ""
    @markers= []
  	#TODO: change false into true
    friendsOnline= Friend.where("isonline = ? and latitude != ? and longitude != ?", "true", 0, 0)
  	@hash =Friend.where("isonline = ? and latitude != ? and longitude != ?", "true", 0, 0) do |friend, marker|
	    if ((friend.latitude != nil && friend.longitude != nil) && !(friend.latitude == 0 && friend.longitude == 0))
	      marker.lat friend.latitude
	      marker.lng friend.longitude
        if (friend.picture.exists?)
          filename = "user_".concat(friend.id.to_s).concat(".png")
          marker.picture({
          "url" => "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/marker/".concat(filename),
          "width" => 30,
          "height" => 40
          })
        else
          marker.picture({
          "url" => "https://s3-us-west-2.amazonaws.com/friendmap/app/public/listimages/marker/mapmarkerdefault.png",
          "width" => 30,
          "height" => 40
          })
        end

	      string = "<p>".concat(friend.name).concat(" ").concat(friend.surname).concat("</p> <p>").concat(friend.address).concat("</p>")
	      marker.infowindow string
        @markers.push(marker)
    	end
	  end
  end

  def about
  	 @pending_requests = FriendRequest.where("otherfriend= ?", current_friend)
  end
end
