class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, default: 0, null: false
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tasks, [ :project_id, :status ]
  end
end
