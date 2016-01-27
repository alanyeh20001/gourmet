class AddPhotoColumnsToRestaurants < ActiveRecord::Migration
  def up
    add_attachment :restaurants, :photo
  end

  def down
    remove_attachment :restaurants, :photo
  end
end
