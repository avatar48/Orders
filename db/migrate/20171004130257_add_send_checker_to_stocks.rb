class AddSendCheckerToStocks < ActiveRecord::Migration[5.0]
  def change
    add_column :stocks, :send_cheker, :boolean
  end
end
