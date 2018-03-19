class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_document, only: [:show, :update, :destroy]

  def index
  	@invoices = Invoice.all
  end

  def edit
  	@lineitems = InvoiceLineItem.where(:invoice_id => params[:format])
  end

  def send_invoice
    @document = Invoice.find(params[:format])
    @invoice = DataMigrator.new(doc: @document)
    @invoice.get_product_invoice
    @invoice.send_to_mssql ? @message = 'Успешно отправлена' : @message = 'уже отправлена'
    redirect_to invoices_url, notice: "Реализация #{@document.number} #{@message}"
  end

  def upload_invoice
  	uploaded_io = params[:invoice]
    if uploaded_io.nil? 
      redirect_to invoices_url, notice: 'Выберите файл'
      return
    end
    
    filename = Rails.root.join('public', 'uploads', uploaded_io.original_filename)
    
    File.open(filename, 'wb') do |file|
  	  file.write(uploaded_io.read)
    end

    ParseFileJob.perform_later(filename.to_s, 'invoice')
    respond_to do |format|
      format.html {redirect_to invoices_url}
      format.js 
    end  
  end

  def show
    respond_to do |format|
      format.html 
      format.xlsx {render xlsx: 'download',filename: "#{@document.number}.xlsx"}
    end
  end

  def destroy
    @invoice = DataMigrator.new(doc: @document)
    @invoice.destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Документ #{@document.number} удален." }
      format.json { head :ок }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Invoice.find(params[:id])
  end

end
