FactoryGirl.define do
  factory :invoice do
    number {Faker::Code.ean}
    date {Faker::Time.backward(14, :all).strftime("%d.%m.%Y %H:%m:%S")}
    sum "5569.5"
    seller_inn "5043029726"
    saler_kpp "501401001"
    buyer_inn "5043029726"
    buyer_kpp ""
    send_cheker "false"
    partner_id "12"
  end
end
  