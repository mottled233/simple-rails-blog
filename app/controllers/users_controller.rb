class UsersController < ApplicationController
  before_action :confirm_logged_in, only: [:index, :edit, :update]
  before_action :confirm_access, only: [:edit, :update]
  before_action :confirm_is_admin, only: [:destroy]
  
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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_param)
      flash[:success] = "success to update user information!"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def destroy
    @users = User.find(params[:id])
    if @users && @users.destroy
      flash[:success] = "success to delete user"
      redirect_to users_path
    else
      flash[:danger] = "fail to delete user"
      redirect_to users_path
    end
  end
  
  private
    def user_param
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def confirm_logged_in
      unless log_in?
        store_location
        flash[:danger] = "You should log in first!"
        redirect_to login_path
      end
    end
    
    def confirm_access
      unless params[:id] == current_user.id.to_s
        flash[:danger] = "You have no authority to access that page!"
        redirect_to home_path
      end
    end
    
    def confirm_is_admin
      unless current_user.admin?
        flash[:danger] = "You have no authority to access that page!"
        redirect_to home_path
      end
    end
    
    
end
