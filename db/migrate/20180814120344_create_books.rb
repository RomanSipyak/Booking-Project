class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.datetime :StartBooking
      t.datetime :EndBooking
      t.float :TotalPrice
      t.integer :item_id
      t.integer :user_id

      t.timestamps
    end
  end
end
