class CreateContractorAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :contractor_availabilities do |t|
      t.date :date_available
      t.references :job, foreign_key: true
      t.references :contractor, index: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
