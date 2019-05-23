class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.references :contractor, index: true, foreign_key: { to_table: :users }
      t.references :job, foreign_key: true
      t.integer :price
      t.boolean :submitted
      t.boolean :accepted

      t.timestamps
    end
  end
end
