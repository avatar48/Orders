class CreateLineitems < ActiveRecord::Migration[5.0]
  def change
    create_table :lineitems do |t|
      t.string :product_name
      t.integer :quantity
      t.decimal :price, precision: 8, scale: 2
      t.string :unit
      t.integer :code_contr
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
