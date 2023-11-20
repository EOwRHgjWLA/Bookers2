class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]

  def new
    @user = User.new
  end

  def index
    @books = Book.all
    @users = User.all
  end

  def show
    @books =Book.all
    @user = User.find(params[:id])
  end

  def edit
    is_matching_login_user
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
     render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end


end
