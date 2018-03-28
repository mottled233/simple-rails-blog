class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_param)
    if @user.save
      flash[:success] = "Welcome,#{@user.name}!"
      log_in @user
      remember @user
      
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end
  
  private
    def user_param
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
