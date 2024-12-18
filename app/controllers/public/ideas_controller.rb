class Public::IdeasController < ApplicationController
  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    if @idea.save
     redirect_to ideas_path
    else
      render :new
    end
  end

  def index
    @ideas = Idea.page(params[:page]).per(9).order(created_at: :desc)
  end

  def show
    @idea = Idea.find(params[:id])
    @idea_comment = IdeaComment.new
  end

  def destroy
    idea = Idea.find(params[:id])
    idea.delete
    redirect_to ideas_path
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    idea = Idea.find(params[:id])
    idea.update(idea_params)
    redirect_to idea_path(idea.id)
  end

  def search
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :body, :image)
  end
end
