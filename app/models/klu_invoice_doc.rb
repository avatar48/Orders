class KluInvoiceDoc < ActiveRecord::Base
	KluInvoiceDoc.establish_connection Rails.application.config.database_configuration['mssql']
	self.table_name = 'dbo._KLUGIRISFIS'

end
