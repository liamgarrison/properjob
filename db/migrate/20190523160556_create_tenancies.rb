class CreateTenancies < ActiveRecord::Migration[5.2]
  def change
    create_table :tenancies do |t|
      t.references :tenant, index: true, foreign_key: { to_table: :users }
      t.references :property, foreign_key: true

      t.timestamps
    end
  end
end
