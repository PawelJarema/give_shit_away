class EditItems < ActiveRecord::Migration
  def change
	remove_column :items, :category
	add_column :items, :category_name, :string

	add_column :items, :category_id, :integer
  end
end
