class UsersController < ApplicationController

  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
    @book = Book.new
    # @books = @user.books.all
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "User was successfully updated."
  	   redirect_to user_path(@user.id)
    else
       @users = User.all
       render action: :edit
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
