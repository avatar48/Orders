class CreateStocksLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks_line_items do |t|
      t.string :product_name
      t.string :unit
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.integer :code_contr
      t.references :stock, foreign_key: true

      t.timestamps
    end
  end
end
