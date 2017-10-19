class Stock < ApplicationRecord
	has_many :stocks_line_items , dependent: :destroy
end
