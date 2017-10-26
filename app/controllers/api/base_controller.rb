class Api::BaseController < ApplicationController
  before_action :require_authenticated_user!

  respond_to :json

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
end
