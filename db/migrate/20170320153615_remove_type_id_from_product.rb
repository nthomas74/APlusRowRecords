class RemoveTypeIdFromProduct < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :type_id, :integer
  end
end
