class Admin::IdeasController < ApplicationController

  layout 'admin'
  before_action :authenticate_admin!

   def index
     @idea = Idea.all
     @ideacomments = IdeaComment.all
   end

   def destroy
     @idea = Idea.find(params[:id])
     @idea.destroy
        redirect_to admin_ideas_path, notice: 'コメントを削除しました。'
   end

end
