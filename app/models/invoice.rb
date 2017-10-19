class Invoice < ApplicationRecord
	has_many :invoice_line_items, dependent: :destroy
end
