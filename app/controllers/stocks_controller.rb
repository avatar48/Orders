class StocksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_document, only: [:show, :update, :destroy]
  before_action :set_lineitems, only: :show

  def index
    @docunemts = Stock.order('number')
    respond_to do |format|
      format.html

    end
  end

  def send_stock
    doc = Stock.find(params[:format])
    if !doc.send_cheker
      doclg = KluInvoiceDoc.create( :FIS_NO => doc.number, :DATE => doc.date, :TOPLAM => doc.sum, :INN => "5263112049")
      @lines =  StocksLineItem.select("code_contr, product_name, sum(quantity) as quantity, price").where(:stock_id => params[:format]).group(:product_name)
      @lines.each do |line|
        price = line.price || 0
        KluInvoiceItem.create(:CODE => line.code_contr, :NAME => line.product_name, :MIKTAR => line.quantity, :BIRIMFIYAT => price, :TOPLAM =>  price * line.quantity, :FISCODE => doc.number )
      end
      doc.update_attribute(:send_cheker, true)
      redirect_to stocks_list_url
    else
      redirect_to stocks_list_url, notice: "Заявка на перемещение #{doc.number} уже отправлена"
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

  def show
    respond_to do |format|
      format.html 
      format.xlsx {render xlsx: 'download',filename: "#{@document.number}.xlsx"}
  end
    
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Stock.find(params[:id])
  end

  def set_lineitems
    @lineitems = StocksLineItem.where(:stock_id => params[:id])
  end

end