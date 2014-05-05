class CreateProviders < ActiveRecord::Migration
  
  def change
    create_table :providers do |t|
      t.string :name
      t.string :email
      t.string :department
      t.string :hospitaL_id
      t.timestamps
    end
  
  end
end
