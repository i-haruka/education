class Public::IdeaCommentsController < ApplicationController

  def create
    idea = Idea.find(params[:idea_id])
    comment = current_user.idea_comments.new(idea_comment_params)
    comment.idea_id = idea.id
    comment.save
    redirect_to idea_path(idea)
  end

  def destroy
    IdeaComment.find(params[:id]).destroy
    redirect_to idea_path(params[:idea_id])
  end

  private

  def idea_comment_params
    params.require(:idea_comment).permit(:comment)
  end
end
