class InvoicesController < ApplicationController
  def list
  	@invoices = Invoice.all
  end

  def edit

  	@lineitems = InvoiceLineItem.where(:invoice_id => params[:format])
  	
  end

  def send_invoice
    doc = Invoice.find(params[:format])
    KluInvoiceDoc.create(:FIS_NO => doc.number, :DATE => doc.date, :TOPLAM => doc.sum, :FIRMA_AD => "dsds")
    @lines =  InvoiceLineItem.where(:invoice_id => params[:format])
    @lines.each do |line|
      KluInvoiceItem.create(:CODE => line.partner_code, :NAME => line.product_name, :MIKTAR => line.quantity, :BIRIMFIYAT => line.price, :TOPLAM =>  line.price * line.quantity, :FISCODE => doc.number )
    end
  end

  def upload_invoice
  	uploaded_io = params[:invoice]
  	File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
  	    file.write(uploaded_io.read)
  	    #byebug
  	    doc = File.open(uploaded_io.path) { |f| Nokogiri::XML(f) }
        doc.xpath("//Шапка//Документ").map.each do |s|
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
    redirect_to invoices_list_url
  end
end
