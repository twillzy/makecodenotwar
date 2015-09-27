class UsersController < ApplicationController

  before_action :require_login

  def index
  	@users = User.all
  end

  def edit
  end

  def profile
  end

  def matches
  end
end
