class CreateUserProductLikes < ActiveRecord::Migration
  def change
    create_table :user_product_likes do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps
    end
  end
end
