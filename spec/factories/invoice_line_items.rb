FactoryGirl.define do
  factory :item_plintus, class: InvoiceLineItem do
    product_name "Плинтус"
    product_code "x2-3"
    quantity "2"
    price "30"
    unit "шт"
    partner_code "345"
    invoice
  end

  factory :item_panel, class: InvoiceLineItem do
    product_name "Панель"
    product_code "x5-7"
    quantity "10"
    price "20"
    unit "уп"
    partner_code "123"
    invoice
  end
end
  