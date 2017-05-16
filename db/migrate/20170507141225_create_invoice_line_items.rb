class CreateInvoiceLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_line_items do |t|
      t.string :product_name
      t.string :product_code
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.string :unit
      t.string :partner_code
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
