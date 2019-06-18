class RemovePropertyFromJob < ActiveRecord::Migration[5.2]
  def change
    remove_reference :jobs, :property, foreign_key: true
  end
end
