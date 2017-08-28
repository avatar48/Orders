class ParseStokFileJob < ApplicationJob
    queue_as :default

    def perform(path)
        doc = File.open(path) { |f| Nokogiri::XML(f) }
        doc.xpath("//Документ").map.each do |s|
            stock = Stock.find_by(:number => "#{s['Номер']}")
            if stock.nil? and s['ИННПокупатель'] == s['ИННПродавец']                         
                document = Stock.new
                document.number = s['Номер']
                document.date = s['Дата']
                document.sum = s['СуммаДокумента']
                document.inn = s['ИННПокупатель']
                document.save
                s.xpath("//СтрокаТовары").map.each do |c|
                    lineitem = StocksLineItem.new
                    lineitem.product_name = c['НоменклатураНаименование']
                    lineitem.quantity = c['Количество']
                    lineitem.unit = c['ЕдиницаИзмеренияНаименование']
                    lineitem.code_contr = c['КодКонтрагента']
                    lineitem.stock_id = document.id
                    lineitem.price = c['Цена']
                    lineitem.save
                end
            end
        end                
    end

end          
