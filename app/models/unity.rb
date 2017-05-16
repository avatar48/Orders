class Unity < ActiveRecord::Base

#s
#establish_connection 'mssql'
 establish_connection({
    :adapter     => "sqlserver",
    :host          => "192.168.0.10",
    :username => "rails",
    :password => "q1w2e3r4",
    :database => "rails_test"
  })
self.table_name = 'dbo.People'
end
