class Invoice < ApplicationRecord
	has_many :invoicelineitem
end
