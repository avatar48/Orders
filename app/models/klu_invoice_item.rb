class KluInvoiceItem < ActiveRecord::Base
	KluInvoiceItem.establish_connection Rails.application.config.database_configuration["#{Rails.env}_mssql"]
	self.table_name = '_KLUGIRISSATIR'

end
