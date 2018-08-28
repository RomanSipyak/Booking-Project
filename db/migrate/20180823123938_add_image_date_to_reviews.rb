class AddImageDateToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :image_data, :text
  end
end
