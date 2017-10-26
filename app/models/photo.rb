class Photo < ApplicationRecord
  belongs_to :user

  mount_uploader :photo_content, PhotoUploader

  validates :title, presence: true
  validates :photo_content, presence: true
  validates :user, presence: true
end
