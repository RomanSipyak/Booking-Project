class Review < ApplicationRecord
  belongs_to :reviewcontainer, polymorphic: true
end
