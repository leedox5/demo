class Admin::UsersController < ApplicationController
  before_action :require_admin!
  before_action :set_user, only: [ :update ]

  def index
    @users = User.order(created_at: :desc)
  end

  def update
    if demote_request? && self_demote?
      redirect_to admin_users_path, alert: "자기 자신의 관리자 권한은 해제할 수 없습니다."
      return
    end

    if demote_request? && last_admin?(@user)
      redirect_to admin_users_path, alert: "마지막 관리자 계정은 권한을 해제할 수 없습니다."
      return
    end

    @user.update!(is_admin: target_admin_value)
    notice = @user.is_admin? ? "관리자 권한을 부여했습니다." : "관리자 권한을 해제했습니다."
    redirect_to admin_users_path, notice: notice
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def target_admin_value
    ActiveModel::Type::Boolean.new.cast(params[:is_admin])
  end

  def demote_request?
    !target_admin_value
  end

  def self_demote?
    @user == current_user
  end

  def last_admin?(user)
    user.is_admin? && User.where(is_admin: true).count == 1
  end
end
