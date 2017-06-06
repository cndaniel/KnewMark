class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "你不是管理员"
    end
  end

  private
  def not_authenticated
    respond_to do |format|
      format.html { redirect_to new_session_path, :alert => "请先登录"}
      format.js {
        flash[:alert] = "请先登录"
        render body: "window.location = '/sessions/new'"}
    end

  end


end
