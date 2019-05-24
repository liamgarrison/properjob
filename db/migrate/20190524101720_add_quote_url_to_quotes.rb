class AddQuoteUrlToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_column :quotes, :quote_url, :string
  end
end
