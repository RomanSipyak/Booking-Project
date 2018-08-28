class Category < ApplicationRecord
  has_many :items, dependent: :destroy
=begin

  extend ItemSplitter

  split(title)
=end
end
