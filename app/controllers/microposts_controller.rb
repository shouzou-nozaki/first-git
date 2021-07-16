class MicropostsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit,:update,:destroy,:show]
  
  def index 
    @microposts = current_user.microposts.order(id: :desc).page(params[:page]).per(10)
    counts(@user)
  end
  
  def update
    @micropost = Micropost.find(params[:id])

    if @micropost.update(micropost_params)
      flash[:success] = '保存されました。'
      redirect_to @micropost
    else
      flash.now[:danger] = '保存されませんでした。'
      render :edit
    end
  end
  
  def edit
    @micropost = Micropost.find(params[:id])
  end
  
  def show 
    @micropost=Micropost.find(params[:id])
  end
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = '記事を投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.microposts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '記事を投稿できませんでした。'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = '記事を削除しました。'
    redirect_back(fallback_location: microposts_path)
    
  end
  
  
  
   private

  def micropost_params
    params.require(:micropost).permit(:content,:title)
  end
  
  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to microposts_path
    end
  end

end
