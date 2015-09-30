class UsersController < ApplicationController

  before_action :require_login
  before_action :set_user, only: [:edit, :profile, :update, :destroy, :get_email, :matches, :get_question, :put_solution]

  def index
      if params[:id]
        @users = User.gender(current_user).not_me(current_user).where('id < ?', params[:id]).limit(10) - current_user.matches(current_user)
      else
        @users = User.gender(current_user).not_me(current_user).limit(10) - current_user.matches(current_user)
      end

      respond_to do |format|
        format.html
        format.js
      end

  end



  def edit
    authorize! :update, @user
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
    authorize! :read, @user
    @matches = current_user.friendships.where(state: "ACTIVE").map(&:friend) + current_user.inverse_friendships.where(state: "ACTIVE").map(&:user)
    # raise "hello"
  end

  def get_email
    respond_to do |format|
      format.js
    end
  end

  def get_question
    respond_to do |format|
      format.js
    end
  end

  def put_solution
      inverse_friendship = current_user.inverse_friendships.where(user_id: current_user.id)

        friendship = current_user.friendships.where(friend_id: @user.id).first
         if inverse_friendship.blank?
    friendship.update_attribute(:usersolution, params['solution']) 
  else  
      friendship.update_attribute(:friendsolution, params['solution'])   

       render :json => []
   end    
  end



  private

  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:interest, :bio, :avatar, :location, :date_of_birth, :question)
  end
end

    #get the friendship, and figuer out if friend or user , and then figure out which slot to put in 
    #  @this_inverse_friendship = current_user.inverse_friendships.where(user_id: current_user.id)
    # if @this_inverse_friendship.blank?
    #   current_user.friendships.where(friend_id: @user.id).first.update_attribute(:usersolution, params['solution'])
    #  else 
    #   @user.friendships.where(friend_id: current_user.id).first.update_attribute(:friendsolution, params['solution'])        
 
    # end


  #     inverse_friendship = current_user.inverse_friendships.where(user_id: current_user.id)

  #       friendship = current_user.friendships.where(friend_id: @user.id).first
  #        if inverse_friendship.blank?
  #   friendship.update_attribute(:usersolution, params['solution']) 
  # else  
  #     friendship.update_attribute(:friendsolution, params['solution']) 


