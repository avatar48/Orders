class KluInvoiceDoc < ActiveRecord::Base
	KluInvoiceDoc.establish_connection Rails.application.config.database_configuration["#{Rails.env}_mssql"]
	self.table_name = '_KLUGIRISFIS'

end
