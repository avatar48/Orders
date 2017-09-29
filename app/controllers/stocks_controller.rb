class StocksController < ApplicationController
  before_filter :authenticate_user!

  def list
    @docunemts = Stock.all
  end

  def send_stock
    doc = Stock.find(params[:format])
    doclg = KluInvoiceDoc.create( :FIS_NO => doc.number, :DATE => doc.date, :TOPLAM => doc.sum, :INN => "5263112049")
    @lines =  StocksLineItem.select("code_contr, product_name, sum(quantity) as quantity, price").where(:stock_id => params[:format]).group(:product_name)
    @lines.each do |line|
      price = line.price || 0
      KluInvoiceItem.create(:CODE => line.code_contr, :NAME => line.product_name, :MIKTAR => line.quantity, :BIRIMFIYAT => price, :TOPLAM =>  price * line.quantity, :FISCODE => doc.number )
    end
  end

  def upload_stock
    uploaded_io = params[:invoice]
    if uploaded_io.nil?
      redirect_to stocks_list_url, notice: "Выберите файл"
    return
    end

    filename = Rails.root.join('public', 'uploads', uploaded_io.original_filename)

    File.open(filename, 'wb') do |file|
            file.write(uploaded_io.read)
        end
    ParseStokFileJob.perform_later(filename.to_s)
    
    respond_to do |format|
        format.html {redirect_to stocks_list_url}
        format.js 
    end

  end

  def edit
        @lineitems = StocksLineItem.where(:stock_id => params[:format])
  end


end