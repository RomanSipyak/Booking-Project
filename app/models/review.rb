class Review < ApplicationRecord
  include ImageUploader::Attachment.new(:image)
  belongs_to :reviewcontainer, polymorphic: true
end
