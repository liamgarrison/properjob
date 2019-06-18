class RemoveTenantFromProperties < ActiveRecord::Migration[5.2]
  def change
    remove_reference :properties, :tenant, foreign_key: { to_table: :users }
  end
end
