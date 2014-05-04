class CreateProviders < ActiveRecord::Migration
  
  def change
    create_table :providers do |t|
      t.string :name
      t.string :email
      t.string :hospitaL_id
      t.datetime :practicing_since
      t.string :school
      t.string :residency
      t.timestamps
    end
  
  end
end
