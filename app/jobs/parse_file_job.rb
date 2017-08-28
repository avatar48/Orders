class ParseFileJob < ApplicationJob
    queue_as :default

    def perform(path)
        doc = File.open(path) { |f| Nokogiri::XML(f) }
                  doc.xpath("//Документ").map.each do |s|                  
        document = Invoice.new
          document.number = s['Номер']
          document.date = s['Дата']
          document.sum = s['СуммаДокумента']
          document.seller_inn = s['ИННПродавец']
          document.saler_kpp = s['КПППродавец']
          document.buyer_inn = s['ИННПокупатель']
          document.buyer_kpp = s['КПППокупатель']
          document.save
          s.xpath("//СтрокаТовары").map.each do |c|
              lineitem = InvoiceLineItem.new
              lineitem.product_code = c['НоменклатураКод']
              lineitem.product_name = c['НоменклатураНаименование']
              lineitem.quantity = c['Количество']
              lineitem.unit = c['ЕдиницаИзмеренияНаименование']
              lineitem.partner_code = c['КодКонтрагента']
              lineitem.price = c['Цена']
              lineitem.invoice_id = document.id
              lineitem.save
                        end

                end                
    end

end          
