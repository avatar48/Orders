class DocumentLgBase 
  attr_accessor :doc

  def initialize(doc)
    @doc = doc
  end

  # def self.is_invoice? str
  #   !str.match(/^(\D)?[0-9]/).nil?
  # end

  # def self.is_stock? str
  #   !str.match(/^(\D){2}[0-9]/).nil?
  # end

# Получить документ из базы LG
  def get_lg_document
    @lgdocument = KluInvoiceDoc.where(:FIS_NO => @doc.number)
    @items = KluInvoiceItem.where(:FISCODE => @doc.number)
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
      KluInvoiceDoc.create(:FIS_NO => doc.number, :DATE => doc.date, :TOPLAM => doc.sum, :INN => "5263112049")
      @product.each do |line|
        price = line.price || 0
        KluInvoiceItem.create(:CODE => line.partner_code, :NAME => line.product_name, :MIKTAR => line.quantity, :BIRIMFIYAT => price, :TOPLAM =>  price * line.quantity, :FISCODE => doc.number )
      end
      doc.update_attribute(:send_cheker, true)
    end
  end

  def destroy
    get_lg_document
    if !@lgdocument.empty?
      @lgdocument.delete_all
    end 
    if !@items.empty?
      @items.delete_all
    end 
  end 
end