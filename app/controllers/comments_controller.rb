class CommentsController < ApplicationController
  def create
    message = Message.new(message_params)
  end

  private

  def message_params
    params.require(comment).permit(:text).merge(user_id: current_user.id, laundry_id: params[:laundry_id])
  end
end
