class UsersController < ApplicationController
  before_action :require_user_logged_in
  

  def show
    @user=User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    
     if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
     end
  end

  def new
    @user = User.new
  end
  
  def edit
    @user=User.find(params[:id])
     
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = '保存されました。'
      redirect_to @user
    else
      flash.now[:danger] = '保存されませんでした。'
      render :edit
    end
 
  end
  
end


  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    
  end

 private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:introduce)
  end
