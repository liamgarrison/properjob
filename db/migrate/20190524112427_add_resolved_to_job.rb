class AddResolvedToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :resolved, :boolean
  end
end
