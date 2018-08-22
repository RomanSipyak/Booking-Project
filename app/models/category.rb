class Category < ApplicationRecord
  has_many :items, dependent: :destroy

  extend ItemSplitter

  split(title)
end
