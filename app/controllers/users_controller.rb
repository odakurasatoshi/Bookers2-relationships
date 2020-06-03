class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_login_user, :new_book

  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
    # @books = @user.books.all
  end

  def edit
  end

  def update
    if @user.update(user_params)
       flash[:notice] = "User was successfully updated."
  	   redirect_to user_path(@user.id)
    else
       @users = User.all
       render action: :edit
    end
  end

  protected
    def find_login_user
      @user = User.find(current_user.id)
    end

    def new_book
      @book = Book.new
    end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
