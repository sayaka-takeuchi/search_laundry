class CommentsController < ApplicationController
  def create
    @message = Comment.new(message_params)
    if @message.save
      ActionCable.server.broadcast 'comment_channel', name: current_user.nickname, text: @message
    end
  end

  private

  def message_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, laundry_id: params[:laundry_id])
  end
end
