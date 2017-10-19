class ParseStokFileJob < ApplicationJob
    queue_as :default

    def create_doc(s)
        document = Stock.new
        document.number = s['Номер']
        document.date = s['Дата']
        document.sum = s['СуммаДокумента']
        document.inn = s['ИННПокупатель']
        document.save
        s.xpath("//СтрокаТовары").map.each do |c|
            lineitem = document.stocks_line_items.new
            lineitem.product_name = c['НоменклатураНаименование']
            lineitem.quantity = c['Количество']
            lineitem.unit = c['ЕдиницаИзмеренияНаименование']
            lineitem.code_contr = c['КодКонтрагента']
            lineitem.price = c['Цена']
            lineitem.save
        end
    end

    def perform(path)
        doc = File.open(path) { |f| Nokogiri::XML(f) }
        doc.xpath("//Документ").map.each do |s|
            stock = Stock.find_by(:number => "#{s['Номер']}")
            if stock.nil? and s['ИННПокупатель'] == s['ИННПродавец']                         
                create_doc(s)   
            end
        end                
    end

end          
