class RemoveHashFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :hash, :string
  end
end
