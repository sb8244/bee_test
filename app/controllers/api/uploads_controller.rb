class Api::UploadsController < Api::BaseController
  def create
    photo = current_user.photos.create(photo_params)
    respond_with :api, photo, location: nil
  end

  private

  def photo_params
    params.permit(:title, :photo_content)
  end
end
