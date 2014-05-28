class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.boolean :item_sent
      t.boolean :concluded, default: false

      # adding indexes
      t.integer :seller_id
      t.integer :buyer_id
      t.integer :item_id

      t.timestamps
    end
  end
end
