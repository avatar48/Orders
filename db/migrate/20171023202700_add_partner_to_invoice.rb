class AddPartnerToInvoice < ActiveRecord::Migration[5.0]
  def change
    add_reference :invoices, :partner, foreign_key: true
  end
end
