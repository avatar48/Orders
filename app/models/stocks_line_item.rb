class StocksLineItem < ApplicationRecord
  belongs_to :stock

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << StocksLineItem.attribute_names
      StocksLineItem.all.each do |result|
        csv << result.attributes.values
      end
    end
  end


end
