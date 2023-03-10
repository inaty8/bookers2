class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end
    
  def index
        @user=current_user
        @users=User.all
        @book = Book.new
  end

  def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to user_path(@user.id),notice:"successfully."
        else
          render :edit
        end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id!=current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  private

  def user_params
        params.require(:user).permit(:name, :profile_image,:introduction)
  end
end
