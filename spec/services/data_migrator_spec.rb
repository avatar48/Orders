require 'rails_helper'
RSpec.describe DataMigrator, type: :model do
  before :each do
    @invoice = FactoryBot.create(:invoice_with_invoice_line_item)
  end

  it 'should create mssql' do
    data = DataMigrator.new(doc: @invoice, type: :invoice)
    data.get_product_invoice
    data.send_to_mssql
    expect(KluInvoiceDoc.exists?(FIS_NO: @invoice.number)).to be true
    expect(KluInvoiceItem.where(FISCODE: @invoice.number).count).to eq 2
  end

  it 'should be destroy from mssql' do
    data = DataMigrator.new(doc: @invoice, type: :invoice)
    data.get_product_invoice
    data.send_to_mssql
    data.destroy
    expect(data.lgdocument.reject(&:destroyed?).empty?).to be true
    expect(data.items.reject(&:destroyed?).empty?).to be true
  end
end
