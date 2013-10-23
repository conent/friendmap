class ApplicationController < ActionController::Base
  protect_from_forgery
  around_filter :set_current_friend

  def set_current_friend
    Friend.current_friend = Friend.find_by_id(session[:friend_id])
    yield
  ensure
    # to address the thread variable leak issues in Puma/Thin webserver
    Friend.current_friend = nil
  end             
end
