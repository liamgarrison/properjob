class CreateJobStages < ActiveRecord::Migration[5.2]
  def change
    create_table :job_stages do |t|
      t.references :job, foreign_key: true
      t.integer :stage

      t.timestamps
    end
  end
end
