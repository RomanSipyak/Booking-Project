class AddRatingTradeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :rating_trade, :float
  end
end
