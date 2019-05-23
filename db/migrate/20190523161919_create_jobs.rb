class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.references :property, foreign_key: true
      t.string :category
      t.text :description
      t.references :contractor, index: true, foreign_key: { to_table: :users }
      t.integer :current_stage
      t.date :date
      t.integer :final_price

      t.timestamps
    end
  end
end
