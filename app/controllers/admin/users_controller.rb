class Admin::UsersController < ApplicationController
  before_action :admin_user, only: [:index, :destroy]

  def index
    @users = User.order('created_at DESC')
    @laundries = Laundry.order('created_at DESC')
    @comments = Comment.all
    
    respond_to do |format|
      format.html
      format.csv { send_data render_to_string, filename: "#{Time.now.to_date.to_s}.csv" }
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:success] = '削除が完了しました'
      redirect_to admin_users_path
    else
      flash[:failure] = '削除が失敗しました'
      redirect_to admin_users_path
    end
  end

  private

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end