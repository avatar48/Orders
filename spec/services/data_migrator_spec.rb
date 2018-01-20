require 'rails_helper'

RSpec.describe DataMigrator, type: :model do
  before :each do
    @invoice = FactoryGirl.create(:invoice)
    @line = FactoryGirl.create(:invoice_line_item, invoice_id:  @invoice)
  end


  it 'should create mssql' do
    data = DataMigrator.new(doc: @invoice)
    data.get_product_invoice
    data.send_to_mssql
    expect(KluInvoiceDoc.exists?(FIS_NO: @invoice.number)).to be true
  end

  it 'should be destroy from mssql' do
    data = DataMigrator.new(doc: @invoice)
    data.get_product_invoice
    data.send_to_mssql
    data.destroy
    expect(data.lgdocument.destroyed?).to be true
    expect(data.items.reject(&:destroyed?).empty?).to be true
  end

end
