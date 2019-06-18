class AddTenancyToJob < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :tenancy, foreign_key: true
  end
end
