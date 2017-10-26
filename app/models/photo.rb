class Photo < ApplicationRecord
  validates :title, presence: true
end
