class KluStockDoc < ActiveRecord::Base
	KluStockDoc.establish_connection Rails.application.config.database_configuration['mssql']
	self.table_name = 'dbo._KLUDEPOFIS'
end
