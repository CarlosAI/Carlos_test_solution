class AddTaglineToBeers < ActiveRecord::Migration[5.2]
  def change
    add_column :beers, :tagline, :string
  end
end
