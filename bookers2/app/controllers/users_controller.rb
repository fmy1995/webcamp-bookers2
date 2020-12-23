class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order
    @book = Book.new
    @book_comments =BookComment.all
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:notice] = "successfully updated."
    else
    render 'edit'
    end
  end

  def followeds
    @user =User.find(params[:id])
    @users =@user.followeds
    render 'followeds'
  end

  def followers
    @user =User.find(params[:id])
    @users =@user.followers
    render 'followers'
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
