class Api::BaseController < ApplicationController
  before_action :require_authenticated_user!

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error

  def current_user
    return nil if auth_token.blank?
    @current_user ||= User.load_from_token(auth_token)
  end

  private

  def require_authenticated_user!
    return if current_user
    render json: { error: "Not authorized" }, status: 401
  end

  def auth_token
    request.headers.fetch('Authorization', '').split('Bearer: ').last
  end

  def not_found_error
    render json: { error: "Not found" }, status: 404
  end
end
