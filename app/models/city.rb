class City < ApplicationRecord
  has_many :users, dependent: :destroy

  extend ItemSplitter

  split(title)
end
