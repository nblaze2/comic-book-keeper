class CreateCollectibles < ActiveRecord::Migration[5.0]
  def change
    create_table :collectibles do |t|
      t.belongs_to :user, foreign_key: true
      t.integer :year
      t.string :media, null: false
      t.string :title, null: false
      t.integer :issue_num
      t.string :publisher
      t.string :writer
      t.string :artist
      t.string :condition
      t.decimal :value
      t.text :desciption

      t.timestamps null: false
    end

    add_index :collectibles, :year
    add_index :collectibles, :media
    add_index :collectibles, :title
    add_index :collectibles, :publisher
    add_index :collectibles, :writer
    add_index :collectibles, :artist
  end
end
