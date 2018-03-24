require 'rails_helper'

RSpec.describe ParserXml, type: :model do
  before :each do
    @file_stock = Rails.root.join('vendor/tets_orders.xml')
    stock = ParserXml.new(@file_stock, Stock)
    stock.open
    stock.read

    @partner = FactoryGirl.create(:partner)
    @file_invoice = Rails.root.join('vendor/tets_invoices.xml')
    invoice = ParserXml.new(@file_invoice, Invoice)
    invoice.open
    invoice.read
  end

  it 'should find stock document in base' do
    expect(Stock.exists?(number: 'УТ000000039')).to be true
    expect(Stock.exists?(number: 'УТ000000041')).to be true
  end

  it 'should find stock item document in base' do
    expect(Stock.find_by(number: 'УТ000000039').stocks_line_items.count).to eq 8
    expect(Stock.find_by(number: 'УТ000000041').stocks_line_items.count).to eq 246
  end

  it 'should find invoice item document in base' do
    expect(Invoice.exists?(number: 'К0000000279')).to be true
    expect(Invoice.exists?(number: 'К0000000231')).to be true
    expect(Invoice.exists?(number: 'К0000000232')).to be true
    expect(Invoice.exists?(number: 'К0000000230')).to be true
    expect(Invoice.exists?(number: 'К0000000233')).to be true
    expect(Invoice.exists?(number: 'К0000000234')).to be true
    expect(Invoice.exists?(number: 'К0000000235')).to be true
  end

  it 'should find invoice item document in base' do
    expect(Invoice.find_by(number: 'К0000000279').invoice_line_items.count).to eq 167
    expect(Invoice.find_by(number: 'К0000000231').invoice_line_items.count).to eq 103
    expect(Invoice.find_by(number: 'К0000000232').invoice_line_items.count).to eq 115
    expect(Invoice.find_by(number: 'К0000000230').invoice_line_items.count).to eq 89
    expect(Invoice.find_by(number: 'К0000000233').invoice_line_items.count).to eq 174
    expect(Invoice.find_by(number: 'К0000000234').invoice_line_items.count).to eq 209
    expect(Invoice.find_by(number: 'К0000000235').invoice_line_items.count).to eq 10
  end

  it 'shold tobe link on partner' do
    expect(Invoice.find_by(number: 'К0000000279').partner).to eq @partner
  end 

end
