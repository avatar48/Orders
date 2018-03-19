class ParseFileJob < ApplicationJob
  queue_as :default

  MODEL = {'stock' => Stock, 'invoice' => Invoice}
  def perform(path, key)
    model = MODEL[key]
    stock = ParserXml.new(path, model)
    stock.open
    stock.read          
  end
end          
