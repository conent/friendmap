module FriendRequestsHelper

	def emailExists (email)
		tagetFriend = Friend.where(email: email).first;

		if (tagetFriend == nil)
			return false;
		else
			return tagetFriend.id;			
		end
		
	end


end
