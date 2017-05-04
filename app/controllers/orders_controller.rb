class OrdersController < ApplicationController
  def edit
  end

  def list
  	@docunemts = Document.all
  end

  def upload
	uploaded_io = params[:invoice]
	File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
	    file.write(uploaded_io.read)
	    #byebug
	    doc = File.open(uploaded_io.path) { |f| Nokogiri::XML(f) }
	 	doc.xpath("//Шапка//Документ").map.each do |s|
	 		document = Document.new
	 		document.number = s['НомерВходящий']
	 		document.date = s['ДатаВходящий']
	 		document.sum = s['СуммаДокумента']
	 		document.inn = s['ИННКонтрагент']
	 		document.save
	 		s.xpath("//СтрокаТовары").map.each do |c|
      			lineitem = Lineitem.new
      			lineitem.product_name = c['НоменклатураНаименование']
      			lineitem.quantity = c['Количество']
      			lineitem.unit = c['ЕдиницаИзмеренияНаименование']
      			lineitem.code_contr = c['КодКонтрагента']
      			lineitem.document_id = document.id
      			lineitem.price = c['Цена']
				lineitem.save

   			end

	 	end
	end
  end
end

