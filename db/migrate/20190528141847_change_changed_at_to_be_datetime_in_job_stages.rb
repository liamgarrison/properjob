class ChangeChangedAtToBeDatetimeInJobStages < ActiveRecord::Migration[5.2]
  def change
    change_column :job_stages, :changed_at, :datetime
  end
end
