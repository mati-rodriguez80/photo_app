class Image < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader

  validate :picture_size

  private

  # This validation could be removed because I am also using "process resize_to_limit: [800, 800]"
  # in "picture_uploader.rb" file. But, I am going to leave it there in case there is an image that,
  # after being resized, it is its size still bigger than 5MB, and also, just in case I need something
  # like this in the future.
  def picture_size
    if picture.size > 5.megabytes
      # This returns <ActiveModel::Error attribute=picture, type=Image should be less than 5MB, options={}>
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
