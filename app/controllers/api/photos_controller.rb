class Api::PhotosController < Api::BaseController
  skip_before_action :require_authenticated_user!, only: [:index, :show]

  def index
    respond_with :api, Photo.all.order(created_at: :desc)
  end

  def show
    respond_with :api, photo
  end

  def create
    photo = current_user.photos.create(photo_params)
    respond_with :api, photo, location: nil
  end

  private

  def photo
    @photo ||= Photo.find(photo_id)
  end

  def photo_id
    params.fetch(:id)
  end

  def photo_params
    params.permit(:title, :photo_content)
  end
end
