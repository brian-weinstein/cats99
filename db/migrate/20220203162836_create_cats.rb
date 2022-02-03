class CreateCats < ActiveRecord::Migration[7.0]
  def change
    create_table :cats do |t|
      t.text :name, null: false
      t.date :birth_date, null: false
      t.text :color, null: false
      t.text :sex, null: false, limit: 1
      t.text :description, null: false

      t.timestamps
    end
  end
end
