class CreateSearches < ActiveRecord::Migration
  
  def change
    create_table :searches do |t|
      t.string :icd_9
      t.string :symptom
      t.string :specialty
      t.string :address # Street address
      t.string :city
      t.string :state
      t.string :zipcode
      t.integer :user_id
      t.timestamps
    end
    add_index :searches, [:user_id, :created_at]
  end
end
