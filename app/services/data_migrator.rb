class DataMigrator

  attr_accessor :doc

  def initialize(doc:)
    @doc = doc
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

  # Отправка в базу LG
  def send_to_mssql
    if !doc.send_cheker
      a = KluInvoiceDoc.create(FIS_NO: doc.number, DATE: doc.date, TOPLAM: doc.sum, INN: '5263112049')
      @product.each do |line|
        price = line.price || 0
        item = KluInvoiceItem.new
        item.code = line.partner_code
        item.name = line.product_name
        item.miktar = line.quantity
        item.birimfiyat = price
        item.toplam = price * line.quantity
        item.fiscode =doc.number
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
