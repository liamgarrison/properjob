class ChangeColumnNamesForCloudinary < ActiveRecord::Migration[5.2]
  def change
    rename_column :photo_videos, :photo_url, :photo_video
    rename_column :jobs, :invoice_url, :invoice
    rename_column :quotes, :quote_url, :quote
  end
end
