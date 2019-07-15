class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.references :user, foreign_key: true
      t.text :title
      t.boolean :completed

      t.timestamps
    end
  end
end
