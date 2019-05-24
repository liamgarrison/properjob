class PhotoVideo < ApplicationRecord
  belongs_to :job
  mount_uploader :quote_url, PhotoUploader

end
