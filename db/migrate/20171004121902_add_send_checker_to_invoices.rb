class AddSendCheckerToInvoices < ActiveRecord::Migration[5.0]
  def change
    add_column :invoices, :send_cheker, :boolean
  end
end
