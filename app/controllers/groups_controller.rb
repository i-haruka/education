class GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @idea = Idea.new #アプリの都合上定義しておりますご自身のアプリに合わせて変更して下さい。
    @groups = Group.all
  end

  def show
    @idea = Idea.new #アプリの都合上定義しておりますご自身のアプリに合わせて変更して下さい。
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  # params[:id]を持つ@groupのowner_idカラムのデータと自分のユーザーIDが一緒かどうかを確かめる。
  # 違う場合、処理をする。グループ一覧ページへ遷移させる。before_actionで使用する。
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
