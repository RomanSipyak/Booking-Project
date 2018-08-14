class Item < ApplicationRecord
  has_many :reviews, as: :reviewcontainer
  belongs_to :user
  belongs_to :category
  has_many :books
end
