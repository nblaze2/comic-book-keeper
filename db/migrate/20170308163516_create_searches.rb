class CreateSearches < ActiveRecord::Migration[5.0]
  def change
    create_table :searches do |t|
      t.string :keywords
      t.string :publisher
      t.integer :year
      t.decimal :min_price
      t.decimal :max_price
      t.string :condition

      t.timestamps
    end
  end
end
