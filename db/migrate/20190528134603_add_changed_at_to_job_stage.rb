class AddChangedAtToJobStage < ActiveRecord::Migration[5.2]
  def change
    add_column :job_stages, :changed_at, :date
  end
end
