class ParserXml
  attr_reader :document

  def initialize(file, object)
    @file = file
    @object = object
  end

  def open
    @doc = File.open(@file) { |f| Nokogiri::XML(f) }
    @doc.xpath("//Документ").count
  end

  def read 
    @doc.xpath("//Документ").map do |s|
      unless document_exist? s['Номер']
        crete_stock_document(s) if @object == Stock
        crete_invoice_document(s) if @object == Invoice
        create_lineitems(s)
      end
    end
  end

  def document_exist?(doc_number)
    @object.find_by(number: doc_number) ? true : false
  end

  def crete_stock_document(s)
    @document = @object.create(number: s['Номер'],
                date: s['Дата'],
                sum: s['СуммаДокумента'],
                inn: s['ИННПокупатель'])
  end

  def crete_invoice_document(s)
    # byebug
    @document = @object.create(number: s['Номер'],
                date: s['Дата'],
                sum: s['СуммаДокумента'],
                seller_inn: s['ИННПродавец'],
                saler_kpp: s['КПППродавец'],
                buyer_inn: s['ИННПокупатель'],
                buyer_kpp: s['КПППокупатель'] ,
                partner: Partner.find_by(inn: s['ИННПокупатель']))
  end

  def new_line_items
    if @object == Stock
      @document.stocks_line_items.new
    elsif @object == Invoice
     @document.invoice_line_items.new
    end
  end

  def create_lineitems(s)
    s.xpath("./СтрокаТовары").map do |c|
      lineitem = new_line_items
      lineitem.product_name = c['НоменклатураНаименование']
      lineitem.quantity = c['Количество']
      lineitem.unit = c['ЕдиницаИзмеренияНаименование']
      lineitem.partner_code = c['КодКонтрагента']
      lineitem.price = c['Цена']
      lineitem.save
    end
  end
end
