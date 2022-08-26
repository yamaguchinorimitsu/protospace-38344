class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
                                   #削除  @prototypes = @user.prototypes

  end


end
