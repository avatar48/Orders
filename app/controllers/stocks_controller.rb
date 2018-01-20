class StocksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_document, only: [:show, :update, :destroy]
  before_action :set_mssql_document, only: [:destroy]
  def index
    @docunemts = Stock.all
    respond_to do |format|
      format.html

    end
  end

  def send_stock
    @document = Stock.find(params[:format])
    @stock = DataMigrator.new(doc: @document)
    @stock.get_product_stock
    @stock.send_to_mssql ? @message = 'Успешно отправлена' : @message = 'уже отправлена'
    redirect_to stocks_url, notice: "Перемещение #{@document.number} #{@message}"
  end

  def upload_stock
    uploaded_io = params[:invoice]
    if uploaded_io.nil?
      redirect_to stocks_url, notice: "Выберите файл"
    return
    end

    filename = Rails.root.join('public', 'uploads', uploaded_io.original_filename)

    File.open(filename, 'wb') do |file|
            file.write(uploaded_io.read)
        end
    ParseStokFileJob.perform_later(filename.to_s)
    
    respond_to do |format|
        format.html {redirect_to stocks_url}
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
    @stock = DataMigrator.new(doc: @document)
    @stock.destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: "Документ #{@document.number} удален." }
      format.json { head :no_content }
    end    
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_document
    @document = Stock.find(params[:id])
  end

  def set_mssql_document
    # byebug
    @msdocument = KluInvoiceDoc.where(:FIS_NO => Stock.find(params[:id]).number)
    @mslines =  KluInvoiceItem.where(:FISCODE => Stock.find(params[:id]).number)
    
  end

end