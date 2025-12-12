class AdminController < ApplicationController
  before_action :require_admin

  def dashboard
  end

  private

  def require_admin
    render plain: "Forbidden", status: :forbidden unless current_user&.role == "admin"
  end
end
