class PhotoVideo < ApplicationRecord
  belongs_to :job
  mount_uploader :photo_video, PhotoUploader

end
