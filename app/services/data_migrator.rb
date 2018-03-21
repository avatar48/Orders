class DataMigrator

  attr_accessor :doc

  def initialize(doc:, type: type)
    @doc = doc
    @type = type
  end

  # Получить документ из базы LG
  def lgdocument
    @lgdocument ||= KluInvoiceDoc.find_by(FIS_NO: @doc.number, date: @doc.date)
  end

  def items
    @items ||= KluInvoiceItem.where(FISCODE: @doc.number)
  end

  # Получить номенклатуру документа
  def get_product_stock
    @product = @doc.stocks_line_items.group(:product_name)
  end

  def get_product_invoice
    @product = @doc.invoice_line_items.group(:product_name)
  end

  def create_doc(doc)
    case @type
    when :stock
      KluInvoiceDoc.create(FIS_NO: doc.number, DATE: doc.date, TOPLAM: doc.sum, INN: '5263112049')
    when :invoice
      KluInvoiceDoc.create(:FIS_NO => doc.number, :DATE => doc.date, :TOPLAM => doc.sum, :INN => doc.buyer_inn, :KPP => doc.buyer_kpp)
    end
  end
  # Отправка в базу LG
  def send_to_mssql
    if !doc.send_cheker
      create_doc(doc)
      @product.each do |line|
        price = line.price || 0
        item = KluInvoiceItem.new
        item.CODE = line.partner_code
        item.NAME = line.product_name
        item.MIKTAR = line.quantity
        item.BIRIMFIYAT = price
        item.TOPLAM = price * line.quantity
        item.FISCODE =doc.number
        item.save!
      end
      doc.update_attribute(:send_cheker, true)
      return true
    else
      return false
    end
  end

  def destroy
    lgdocument.delete if lgdocument.present?
    items.delete_all if items.present?
    return @lgdocument
  end
end
