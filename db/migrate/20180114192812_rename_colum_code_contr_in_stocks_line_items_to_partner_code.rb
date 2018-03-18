class RenameColumCodeContrInStocksLineItemsToPartnerCode < ActiveRecord::Migration[5.0]
  def change
    rename_column :stocks_line_items, :code_contr, :partner_code
  end
end
