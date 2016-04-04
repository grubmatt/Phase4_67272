class CreateFlavors < ActiveRecord::Migration
  def change
    create_table :flavors do |t|
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
