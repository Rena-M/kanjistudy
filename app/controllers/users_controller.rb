class UsersController < ApplicationController
  def show
    @nickname = current_user.nickname
    @kanjis = current_user.kanjis.page(params[:page]).per(5).order("created_at DESC")
  end
end
