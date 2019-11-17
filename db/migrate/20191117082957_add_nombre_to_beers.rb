class AddNombreToBeers < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :nombre, :string
  end
end
