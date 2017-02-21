class CreateCollectibles < ActiveRecord::Migration[5.0]
  def change
    create_table :collectibles do |t|
      t.belongs_to :user, foreign_key: true

      t.boolean :keep, default: :false
      t.integer :year
      t.string :media, null: false
      t.string :name_of_item, null: false
      t.string :story_title
      t.integer :vol_num
      t.integer :issue_num
      t.string :publisher
      t.string :cover_artist
      t.string :artist
      t.string :artist2
      t.string :artist3
      t.string :writer
      t.string :condition
      t.decimal :est_value
      t.text :notes

      t.timestamps null: false
    end
  end
end
