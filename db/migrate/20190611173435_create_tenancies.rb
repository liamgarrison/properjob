class CreateTenancies < ActiveRecord::Migration[5.2]
  def change
    create_table :tenancies do |t|
      t.references :property, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :deposit
      t.boolean :deposit_refunded
      t.integer :rent_amount

      t.timestamps
    end
  end
end
