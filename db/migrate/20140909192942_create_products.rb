class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :product_id
      t.string :name
      t.string :list_image
      t.integer :price
      t.integer :brand_id
      t.integer :like_count, :default => 0

      t.timestamps
    end
  end
end
