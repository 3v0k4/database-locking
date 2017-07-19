class CreateUniques < ActiveRecord::Migration[5.1]
  def change
    create_table :uniques do |t|
      t.string :name
      t.index :name, unique: true
    end
  end
end
