class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :store_id
      t.integer :customer_id
      t.boolean :near_location
      t.string :check_in_code

      t.timestamps
    end
  end
end