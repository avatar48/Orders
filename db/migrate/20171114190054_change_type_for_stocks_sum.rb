class ChangeTypeForStocksSum < ActiveRecord::Migration[5.0]
  def change
      change_column :stocks, :sum, :decimal, :precision => 13, :scale => 2
  end
end
