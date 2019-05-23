class CreateProperties < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.references :landlord, index: true, foreign_key: { to_table: :users }
      t.string :address

      t.timestamps
    end
  end
end
