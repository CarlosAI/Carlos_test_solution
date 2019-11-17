class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.date :seen_at
      t.boolean :favorite
      t.integer :user_id

      t.timestamps
    end
  end
end
