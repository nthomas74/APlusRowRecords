class AddTypeIdArtistIdToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :type_id, :integer
    add_column :products, :artist_id, :integer
  end
end
