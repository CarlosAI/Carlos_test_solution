class AddBeerIdToBeers < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :beer_id, :integer
  end
end
