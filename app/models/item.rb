class Item < ApplicationRecord
  has_many :reviews, as: :reviewcontainer
  belongs_to :user
  belongs_to :category
  has_many :books
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
end
