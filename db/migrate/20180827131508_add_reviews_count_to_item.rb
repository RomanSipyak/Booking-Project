class AddReviewsCountToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :review_count, :integer
  end
end
