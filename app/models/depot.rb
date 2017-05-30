class Depot < ApplicationRecord
	establish_connection Rails.application.config.database_configuration['mssql']
end
