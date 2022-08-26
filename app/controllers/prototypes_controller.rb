class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    @prototype.update(prototype_params)

    if @prototype.save
      redirect_to root_path
    else
      render :edit
    end
    
  end

  def  destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy

    redirect_to root_path

  end


  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)

  end

  def create
    @prototype = Prototype.new(prototype_params)

    
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end
  

  private 

  def prototype_params
    params.require(:prototype).permit(:concept,:title,:catch_copy,:user,:image).merge(user_id: current_user.id)
  end


end
