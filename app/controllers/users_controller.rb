class UsersController < ApplicationController

  before_action :require_login
  before_action :set_user, only: [:edit, :profile, :update, :destroy, :get_email, :matches, :get_question, :post_solution, :get_calculator]

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


 # control the ajax post, take the var and push into db
  def get_question
    respond_to do |format|
      format.js
    end
  end

  def get_calculator
    response = Unirest.get "https://love-calculator.p.mashape.com/getPercentage?fname=#{@user.name}&sname=#{current_user.name}",
      headers:{
        "X-Mashape-Key" => "NPNKL3rOHYmshOFMBaiAWKuB4lUMp1lcOZIjsnw5jInt6RSevU",
        "Accept" => "application/json"
      }

    @percentage = response.body["percentage"]
    @result = response.body["result"]
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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def users_params
    params.require(:user).permit(:interest, :bio, :avatar, :location, :date_of_birth, :question)
  end
end

