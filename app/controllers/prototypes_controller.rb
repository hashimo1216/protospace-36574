class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:edit, :show, :update]
  before_action :move_to_index, only: :edit

  def index  
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      # メッセージの保存に成功した場合
      redirect_to root_path
    else
      # メッセージの保存に失敗した場合
      render :new
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end
  
  def move_to_index
    unless current_user == user_signed_in?
      redirect_to action: :index
    end
  end

end
