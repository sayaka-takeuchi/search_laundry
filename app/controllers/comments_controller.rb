class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', name: current_user.nickname, text: @comment, rate: @comment.rate.name
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to laundry_path(comment.laundry_id)
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:text, :gender, :age_id, :rate_id).merge(user_id: current_user.id, laundry_id: params[:laundry_id])
  end
end
