class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :check_user, only: [:show]

  def show
    @comments = @user.comments.includes(:laundry)
  end

  private

  def check_user
    redirect_to root_path unless user_signed_in? && current_user.id == @user.id
  end

  def set_user
    @user = User.find(params[:id])
  end
end
