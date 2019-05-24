class AddRatingToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :rating, :integer
  end
end
