class Image < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader

  validate :picture_size

  private

  def picture_size
    if picture.size > 5.megabytes
      # This returns <ActiveModel::Error attribute=picture, type=Image should be less than 5MB, options={}>
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
