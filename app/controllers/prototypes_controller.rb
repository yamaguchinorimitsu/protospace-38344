class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]


  def index
    @prototypes = Prototype.includes(:user)        #最初はPrototype.all　include使う　N1問題
  end

  def new
    @prototype = Prototype.new
  end

  def edit
                                                     #削除　N1 @prototype = Prototype.find(params[:id])
  end

  def update
                                                      # 削除@prototype = Prototype.find(params[:id])
                                                      # 削除@prototype.update(prototype_params)

    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
    
  end

  def  destroy
    if @prototype.destroy
    redirect_to root_path
    else
    redirect_to root_path
  end

  end

  


  def show
                                               # 間違い　@prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
                                               # 削除@comments = @prototype.comments.includes(:user)

  end

  def create
  @prototype = Prototype.new(prototype_params)

    
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end


  private 

  def prototype_params
    params.require(:prototype).permit(:concept,:title,:catch_copy,:image).merge(user_id: current_user.id)
  end
  
  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end
  
  def set_prototype                                 #この謎を解く
    @prototype = Prototype.find(params[:id])        #この謎を解く
  end

end
