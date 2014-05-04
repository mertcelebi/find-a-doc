class CreateHospitals < ActiveRecord::Migration
  
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :website
      t.timestamps
    end
  
  end
end
