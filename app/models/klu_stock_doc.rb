class KluStockDoc < ApplicationRecord
	ActiveRecord::Base.establish_connection Rails.application.config.database_configuration['mssql']
	self.table_name = 'dbo._KLUDEPOFIS'
end
