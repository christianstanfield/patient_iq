class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :department, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.text :address
      t.string :email
      t.string :password_digest
      t.integer :salary
      t.integer :bonus

      t.timestamps
    end
  end
end
