class Photo < ApplicationRecord
  mount_uploader :photo_content, PhotoUploader

  validates :title, presence: true
end
