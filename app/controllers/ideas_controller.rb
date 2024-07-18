class IdeasController < ApplicationController
  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user_id = current_user.id
    @idea.save
    redirect_to ideas_path
  end

  def index
    @ideas = Idea.all
  end

  def show
    @idea = Idea.find(params[:id])
  end

  def edit
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :image, :caption)
  end
end
