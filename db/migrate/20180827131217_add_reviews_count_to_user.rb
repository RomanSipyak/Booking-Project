class AddReviewsCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :review_count, :integer
  end
end
