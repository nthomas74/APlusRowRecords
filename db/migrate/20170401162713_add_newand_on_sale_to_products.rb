class AddNewandOnSaleToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :new, :boolean
    add_column :products, :on_sale, :boolean
  end
end
