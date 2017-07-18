class CreateForms < ActiveRecord::Migration[5.1]
  def change
    create_table :forms do |t|
      t.string :name
      t.text :content
      t.integer :lock_version
    end
  end
end
