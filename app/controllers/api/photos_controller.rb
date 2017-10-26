class Api::PhotosController < Api::BaseController
  skip_before_action :require_authenticated_user!, only: [:index, :show]

  def index
  end

  def show
    respond_with :api, photo
  end

  private

  def photo
    @photo ||= Photo.find(photo_id)
  end

  def photo_id
    params.fetch(:id)
  end
end
