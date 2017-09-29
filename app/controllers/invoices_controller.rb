class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  def list
  	@invoices = Invoice.order('number')
  end

  def edit
  	@lineitems = InvoiceLineItem.where(:invoice_id => params[:format])
  end

  def send_invoice
    doc = Invoice.find(params[:format])
    KluInvoiceDoc.create(:FIS_NO => doc.number, :DATE => doc.date, :TOPLAM => doc.sum, :INN => doc.buyer_inn, :KPP => doc.buyer_kpp)
    @lines =  InvoiceLineItem.select("id, product_name, product_code, sum(quantity) as quantity, price, unit, partner_code").where(:invoice_id => params[:format]).group(:product_name)
    @lines.each do |line|
      KluInvoiceItem.create(:CODE => line.partner_code, :NAME => line.product_name, :MIKTAR => line.quantity, :BIRIMFIYAT => line.price, :TOPLAM =>  line.price * line.quantity, :FISCODE => doc.number )
    end
  end

  def upload_invoice
  	uploaded_io = params[:invoice]
    if uploaded_io.nil? 
        redirect_to invoices_list_url, notice: "Выберите файл"
        return
    end
    
    filename = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    
    File.open(filename, 'wb') do |file|
  	    file.write(uploaded_io.read)
    end
    ParseInvoiceFileJob.perform_later(filename.to_s)
    respond_to do |format|   
      format.html {redirect_to invoices_list_url}
      format.js 
    end  
  end
end
