class AddMediaToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :media, :string
  end
end
