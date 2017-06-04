class StocksController < ApplicationController
  def list
  	@docunemts = Stock.all
  end

  def send_stock
    doc = Stock.find(params[:format])
    KluStockDoc.create(:FIS_NO => doc.number, :DATE => doc.date, :TOPLAM => doc.sum, :FIRMA_AD => "dsds")
    @lines =  KluStockItem.where(:stock_id => params[:format])
    @lines.each do |line|
      KluStockItem.create(:CODE => line.partner_code, :NAME => line.product_name, :MIKTAR => line.quantity, :BIRIMFIYAT => line.price, :TOPLAM =>  line.price * line.quantity, :FISCODE => doc.number )
    end
  end  

  def upload_stock
  	uploaded_io = params[:invoice]
  	if uploaded_io.nil? 
        redirect_to stocks_list_url, notice: "Выберите файл"
        return
    end
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
	    file.write(uploaded_io.read)
	    #byebug
	    doc = File.open(uploaded_io.path) { |f| Nokogiri::XML(f) }
	 	  doc.xpath("//Шапка//Документ").map.each do |s|
	 		document = Stock.new
	 		document.number = s['НомерВходящий']
	 		document.date = s['ДатаВходящий']
	 		document.sum = s['СуммаДокумента']
	 		document.inn = s['ИННКонтрагент']
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
	redirect_to stocks_list_url
  end

  def edit
  	@lineitems = StocksLineItem.where(:stock_id => params[:format])
  end


end
