class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.addFav(micropost)
    flash[:success] = 'お気に入りに追加しました'
    redirect_to request.referer
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.rmFav(micropost)
    flash[:success] = 'お気に入りを削除しました'
    redirect_to request.referer
  end
end
