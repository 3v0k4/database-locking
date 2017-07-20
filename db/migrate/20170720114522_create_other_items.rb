class CreateOtherItems < ActiveRecord::Migration[5.1]
  def change
    create_table :other_items do |t|
      t.integer :counter
    end
  end
end
