class Item < ApplicationRecord
  has_many :reviews, as: :reviewcontainer
  belongs_to :user
  belongs_to :category
  has_many :books
  validates :price, presence: true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ },
            numericality: { greater_than: 0, less_than: 1000000 }

  scope :by_city, ->(city_ids) { joins(:user).where(labels: { city_id: city_ids }) }
  scope :by_category, ->(category_id) { joins(:category).where(category: { id: category_id }) }
  scope :by_title, ->(str) { where(arel_table[:name].matches("%#{str}%")) }

  def self.book_interval (term_start ,term_end)
    item_table = Item.arel_table
    book_table = Book.arel_table
    bedbooks = Book.where((term_end.qt(book_table[:start_booking])).end(term_start.lt(book_table[:end_booking])))
    Item.where.not(item_table[:id].in(bedbooks.map(&:item_id)))
    end

  table
      .project(table[Arel.star])
      .where(table[:first_name].eq('Ryan').and(table[:last_name].eq('Stenberg')))
      .to_sql
end
