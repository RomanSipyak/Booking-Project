class City < ApplicationRecord
  has_many :users, dependent: :destroy

=begin
  extend ItemSplitter

  split(title)
=end
end
