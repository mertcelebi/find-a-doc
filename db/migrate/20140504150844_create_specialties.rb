class CreateSpecialties < ActiveRecord::Migration
  
  def change
    create_table :specialties do |t|
      t.string :name
      t.string :provider_id
      t.timestamps
    end
  
  end
end
