class Invoice < ApplicationRecord
	has_many :invoice_line_items, dependent: :destroy
	belongs_to :partner
end
