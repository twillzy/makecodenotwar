class UsersController < ApplicationController

  before_action :require_login
  before_action :set_user, only: [:edit, :profile, :update, :destroy, :get_email, :matches, :get_question, :post_solution]


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
     # binding.pry
    # @usersol = current_user.friendships.where(friend_id: current_user.id).first.usersolution
    #   @friendsol = current_user.friendships.where(friend_id: current_user.id).first.friendsolution
     

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

  def notifications
    friend_count = current_user.friendships.where(:state => "ACTIVE").count
    inverse_friend_count = current_user.inverse_friendships.where(:state => "ACTIVE").count
    total = friend_count + inverse_friend_count
    render :json => total
  end




  def post_solution
    self_inverse_friendship = current_user.inverse_friendships.where(friend_id: current_user.id).first
    self_friendship = current_user.friendships.where(friend_id: @user.id).first
    friend_friendship = @user.friendships.where(friend_id: current_user.id).first
          unless self_inverse_friendship.blank?
    friend_friendship.update_attribute(:friendsolution, params['solution']) 
          else  
      self_friendship.update_attribute(:usersolution, params['solution'])   
      end   

    render :json => [] 
     
     end


  # def post_solution
  #   friendship = current_user.friendships.where(friend_id: @user.id).first
  #   friendship.update_attribute(:usersolution, params["solution"] )
  #   render :json => []


  # end


  # inverse_friendship = current_user.inverse_friendships.where(friend_id: @user.id).first


#if there is a solution it will go to the person that has the friendship
#to find a solution we first find if it is a inverse/f or friendship
# then we find the user assoc with friendship 
# 


# if current_user.friendships.where(:friend_id, <% @user.id %>)
# //  //if current user has a inverse_f run this
# //  inverse_friendship 
# //  current_user.inverse_friendship.where(user_id: @friend.id).first.update_attribute(:usersolution, "inputValue");

# // else  
# //  current_user.friendship.where(user_id: @friend.id).first.update_attribute(:usersolution, "inputValue");


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


