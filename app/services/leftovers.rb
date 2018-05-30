class Leftovers

  attr_reader :date

  def initialize(start_date, stock_id)
    @date = Time.parse(start_date)
    @stock_id = stock_id
  end

  def conect
    client = Savon.client(wsdl: ENV['WSDL'], basic_auth: [ENV['USN'], ENV['PAS']])
    x = client.call(:get, message: {date: @date.strftime("%Y-%m-%d"),stock: @stock_id}).to_hash
    @result = x[:get_response][:return][:НоменклатураСписка]
  end

  def to_xml
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') { |xml|
      xml.Шапка('Составил' => 'Имя', 'ДатаСоставления' => "#{Time.now.strftime('%d.%m.%Y %H:%M:%S')}", "ДатаСреза" => "#{@date.strftime("%d.%m.%Y")} 23:59:59") {
        xml.Склад('Наименование' => 'Склад КЛУ'){
          @result.map do |row|
            xml.СтрокаНоменклатура('НоменклатураНаименование' => "#{row[:Наименование]}",
              'Количество' => "#{row[:Количество]}",
              'ЕдиницаИзмеренияНаименование' => "#{row[:ЕдИзм]}", 
              'КодКонтрагента' => "#{row[:Артикул]}"){}
          end
        }
      }
    }
    builder.to_xml
  end
end
