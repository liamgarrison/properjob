class CreateTenantsTenancies < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants_tenancies do |t|
      t.references :tenant, foreign_key: true, foreign_key: { to_table: :users }
      t.references :tenancy, foreign_key: true

      t.timestamps
    end
  end
end
