class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :daily_code
      t.integer :owner_id

      t.timestamps
    end
  end
end