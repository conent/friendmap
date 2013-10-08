class PagesController < ApplicationController
  def home
  	 @pending_requests = FriendRequest.where("otherfriend= ?", current_friend)
  end

  def about
  	 @pending_requests = FriendRequest.where("otherfriend= ?", current_friend)
  end
end
