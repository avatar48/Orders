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

        # factory :course do
        #     times_per_yer 2
        #     description { FFaker::Lorem.paragraph }
        #     language 'English'
        #     name { FFaker::Company.catch_phrase }
        #     url { FFaker::Internet.http_url }
        #     organization
        #     division
        #     campus_site
        #     aasm_state 'collecting'
        #   end
    end

    # factory :invoice2, class Invoice do
    #     number "К0000000124"
    #     date "01.08.2017 0:00:00"
    #     sum "51213.7"
    #     seller_inn "5043029726"
    #     saler_kpp "501401001"
    #     buyer_inn "5043029726"
    #     buyer_kpp ""
    #     send_cheker "false"
    #     partner_id "12"
    # end
  end
  