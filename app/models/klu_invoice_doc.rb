class KluInvoiceDoc < ApplicationRecord
	establish_connection({
    	:adapter     => "sqlserver",
    	:host          => "192.168.0.139",
#    	:username => "rails",
#    	:password => "q1w2e3r4",
#    	:database => "rails_test"
    	:username => "sa",
    	:password => "13034379448",
    	:database => "unitest"
	})
	self.table_name = 'dbo._KLUGIRISFIS'

end
