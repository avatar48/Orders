class DataMigrator 
  attr_accessor :doc

  def initialize(doc: "doc")
    @doc = doc
  end

# Получить документ из базы LG
  def lgdocument
    # @lgdocument ||= KluInvoiceDoc.where(:FIS_NO => @doc.number)
    @lgdocument ||= KluInvoiceDoc.find_by FIS_NO: @doc.number , date: @doc.date
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
      a = KluInvoiceDoc.create(:FIS_NO => doc.number, :DATE => doc.date, :TOPLAM => doc.sum, :INN => "5263112049")
      @product.each do |line|
        price = line.price || 0
        KluInvoiceItem.create(:CODE => line.partner_code, :NAME => line.product_name, :MIKTAR => line.quantity, :BIRIMFIYAT => price, :TOPLAM =>  price * line.quantity, :FISCODE => doc.number )
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