FactoryGirl.define do
  factory :item_plintus, class: InvoiceLineItem do
    product_name "Плинтус"
    product_code "01.08.2017 0:00:00"
    quantity "5569.5"
    price "5043029726"
    unit "501401001"
    partner_code "5043029726"
    invoice
  end

  factory :item_panel, class: InvoiceLineItem do
    product_name "Панель"
    product_code "01.08.2017 0:00:00"
    quantity "5569.5"
    price "5043029726"
    unit "501401001"
    partner_code "5043029726"
    invoice
  end
end
  