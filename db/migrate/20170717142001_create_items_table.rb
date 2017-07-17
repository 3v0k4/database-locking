class CreateItemsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.integer :counter
    end
  end
end
