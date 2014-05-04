class CreateIcd9s < ActiveRecord::Migration
  
  def change
    create_table :icd9s do |t|
      t.string :name
      t.string :icd9_code
      t.string :specialty_id
      t.timestamps
    end
  
  end
end
