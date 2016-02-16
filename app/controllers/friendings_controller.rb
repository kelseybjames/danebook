class FriendingsController < ApplicationController

  def create
    friending_recipient = User.find(params[:id])
    if current_user.friended_users << friending_recipient
      flash[:success] = "Friended #{friending_recipient.profile.first_name}!"
    else
      flash[:error] = 'Failed to add friend'
    end
    redirect_to request.referrer
  end

  def destroy
    unfriended_user = User.find(params[:id])
    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "Unfriended #{unfriended_user.profile.first_name}."
    redirect_to request.referrer
  end
end
