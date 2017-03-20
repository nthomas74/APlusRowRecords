class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :hash
      t.string :salt
      t.string :name
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :email
      t.string :phone_number
      t.boolean :is_admin

      t.timestamps
    end
  end
end
