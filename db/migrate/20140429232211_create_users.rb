class CreateUsers < ActiveRecord::Migration
  
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address # Street address
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :password_digest
      t.boolean :admin, default: false
      t.string :remember_token
      t.index :remember_token # Index session token
      t.index :email # Index email
      t.timestamps
    end
  end

end
