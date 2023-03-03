class UsersController < ApplicationController
  def splash
    if current_user
      redirect_to groups_url, alert: "You are already logged in as, #{current_user.name}"
    else
      render :splash
    end
  end
end
