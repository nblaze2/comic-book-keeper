class AddNameToSearches < ActiveRecord::Migration[5.0]
  def change
    add_column :searches, :name, :string
  end
end
