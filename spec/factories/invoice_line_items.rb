FactoryGirl.define do
  factory :invoice_line_item do
    product_name "К0000000123"
    product_code "01.08.2017 0:00:00"
    quantity "5569.5"
    price "5043029726"
    unit "501401001"
    partner_code "5043029726"
    invoice_id { [association(:invoice)] }
  end
end
  