class AddInvoiceUrlToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :invoice_url, :string
  end
end
