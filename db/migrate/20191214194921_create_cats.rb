class CreateCats < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.string :name
      t.string :user_id
      t.integer :counter, default: 0
    end
  end
end
