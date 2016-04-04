class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :employee_id
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
