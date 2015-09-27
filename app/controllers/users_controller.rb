class UsersController < ApplicationController

  before_action :require_login
  before_action :set_user, only: [:edit, :profile, :update, :destroy]

  def index
      if params[:id]
        @users = User.gender(current_user).not_me(current_user).where('id < ?', params[:id]).limit(10) - current_user.matches(current_user)
      else
        @users = User.gender(current_user).not_me(current_user).limit(10) - current_user.matches(current_user)
      end

      # if params[:id]
      #   @users = User.where('id < ?', params[:id]).limit(2)
      # else
      #   @users = User.all.limit(2)
      # end

        respond_to do |format|
        format.html
        format.js
      end
  end


  def edit
  end

  def update
    if @user.update(users_params)
    respond_to do |format|
      format.html {redirect_to users_path}
    end
    else
      redirect_to edit_user_path(@user)
    end

  end

  def destroy
    if @user.destroy
      session[:user_id] = nil
      session[:omniauth] = nil
      redirect_to root_path
    else
      redirect_to edit_user_path(@user)
    end
  end

  def profile
  end

  def matches
    @matches = current_user.friendships.where(state: "ACTIVE").map(&:friend) + current_user.inverse_friendships.where(state:"ACTIVE").map(&:user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:interest, :bio, :avatar, :location, :date_of_birth)
  end
end
































