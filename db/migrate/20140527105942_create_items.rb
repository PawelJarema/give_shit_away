class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|

      t.string :title
      t.string :category
      t.string :state
      t.float :price
      t.string :description

      t.has_attached_file :photo

      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
