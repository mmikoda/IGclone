class UsersController < ApplicationController
  before_action :own_user, only: [:edit, :update, :destroy]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
        redirect_to user_path(@user.id)
      else
        render :new
      end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to show, notice: "プロフィールを編集しました！"
    else
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation,:photo, :photo_cache)
  end

  def own_user
    if current_user.id != @user.user_id
      redirect_to user_path
    end
  end
end
