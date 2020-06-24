class RelationshipsController < ApplicationController
	before_action :set_user, only: [:create, :destroy]

  def create
    following = current_user.follow(@user)
    following.save
    redirect_to @user
  end

  def following
  	@user = User.find(params[:user_id])
  	@users = @user.followings
  end

  def follower
  	 @user = User.find(params[:user_id])
  	 @users = @user.followers
  end

  def destroy
    following = current_user.unfollow(@user)
    following.destroy
    redirect_to @user
  end

  private
  def set_user
  	@user = User.find(params[:follow_id])
  end
end
