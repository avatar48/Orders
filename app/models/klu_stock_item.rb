class KluStockItem < ActiveRecord::Base
	KluStockItem.establish_connection Rails.application.config.database_configuration['mssql']
	self.table_name = 'dbo._KLUDEPOSATIR'	
end
