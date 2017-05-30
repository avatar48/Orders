class KluInvoiceDoc < ApplicationRecord
	ActiveRecord::Base.establish_connection Rails.application.config.database_configuration['mssql']
	self.table_name = 'dbo._KLUGIRISFIS'

end
