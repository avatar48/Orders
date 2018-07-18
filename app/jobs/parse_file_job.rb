class ParseFileJob
  include Sidekiq::Worker
  include Sidekiq::Status::Worker # Important!
  # queue_as :default

  MODEL = {'stock' => Stock, 'invoice' => Invoice}
  def perform(path, key)
    total 100
    at 0
    model = MODEL[key]
    stock = ParserXml.new(path, model)
    stock.open
    stock.read
    at 100
    store  vino: 'veritas'
  end
end




