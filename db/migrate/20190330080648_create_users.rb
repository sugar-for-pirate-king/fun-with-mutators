class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.integer :grade
      t.string :username

      t.timestamps
    end
  end
end
