class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @profile = @user.profile.attributes unless @user.profile.nil?
  end
end