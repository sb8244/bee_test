class Photo < ApplicationRecord
  mount_uploader :photo_content, PhotoUploader

  validates :title, presence: true
  validates :photo_content, presence: true
end
