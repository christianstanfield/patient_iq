class AddUniqueIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :departments, [:name, :company_id],  unique: true
    add_index :users, :email,  unique: true
  end
end
