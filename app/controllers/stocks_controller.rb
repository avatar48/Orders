class StocksController < ApplicationController
  before_filter :authenticate_user!

  def list
        @docunemts = Stock.all
  end

  def send_stock
    doc = Stock.find(params[:format])
    doclg = KluInvoiceDoc.create(:FIS_NO => doc.number, :DATE => doc.date, :TOPLAM => doc.sum, :INN => "5263112049")
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
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
            file.write(uploaded_io.read)
            #byebug
            doc = File.open(uploaded_io.path) { |f| Nokogiri::XML(f) }
                  doc.xpath("//Документ").map.each do |s|
                        document = Stock.new
                        document.number = s['Номер']
                        document.date = s['Дата']
                        document.sum = s['СуммаДокумента']
                        document.inn = s['ИННПокупатель']
                        document.save
                        s.xpath("СтрокаТовары").map.each do |c|
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