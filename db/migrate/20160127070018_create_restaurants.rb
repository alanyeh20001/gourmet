class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :title
      t.string :website
      t.string :location
      t.integer :user_id
      t.integer :map_id
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
