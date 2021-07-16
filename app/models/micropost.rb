class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 10000 }
  validates :title, presence: true, length: {maximum: 255}
  mount_uploader :image, ImageUploader
end
