class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @memos = @user.memos.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def unsubscribe
  end

  def withdraw
    @user = current_user
    if @user.update(is_active: "退会")
      reset_session
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
