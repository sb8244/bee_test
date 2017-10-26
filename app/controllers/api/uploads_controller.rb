class Api::UploadsController < Api::BaseController
  def create
    photo = Photo.create(photo_params)
    respond_with :api, photo, location: nil
  end

  private

  def photo_params
    params.permit(:title)
  end
end
