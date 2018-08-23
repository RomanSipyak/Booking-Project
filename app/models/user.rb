class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :reviews, as: :reviewcontainer
  belongs_to :city
  has_many :items, dependent: :destroy
  has_many :books, dependent: :destroy

=begin
  extend ItemSplitter

  split(username)
=end
end
