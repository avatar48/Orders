class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :number
      t.date :date
      t.decimal :sum , precision: 8, scale: 2
      t.string :seller_inn, :limit => 10
      t.string :saler_kpp, :limit => 10
      t.string :buyer_inn, :limit => 10
      t.string :buyer_kpp, :limit => 10

      t.timestamps
    end
  end
end
