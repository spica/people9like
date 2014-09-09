class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.integer :brand_id
      t.string :name
      t.string :list_image
      t.integer :like_count, :default => 0

      t.timestamps
    end
  end
end
