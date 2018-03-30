class LeftoversController < ApplicationController
  before_filter :authenticate_user! 
	def send_leftovers
		date = Time.new(params[:start_date][:year].to_i,params[:start_date][:month].to_i,params[:start_date][:day].to_i)
		client = Savon.client(wsdl: ENV['WSDL'], basic_auth: [ENV['USN'], ENV['PAS']])
		x = client.call(:get, message: {date: date.strftime("%Y-%m-%d")}).to_hash
		result = x[:get_response][:return][:НоменклатураСписка]
	# byebug
		 builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') { |xml|
		xml.Шапка('Составил' => '', 'ДатаСоставления' => "#{Time.now.strftime('%d.%m.%y %H:%M:%S')}", "ДатаСреза" => "#{date.strftime("%d.%m.%y")} 23:59:59") {
			xml.Склад('Наименование' => 'Склад КЛУ'){
				result.map do |row|

					xml.СтрокаНоменклатура('НоменклатураНаименование' => "#{row[:Наименование]}",'Количество' => "#{row[:Количество]}", 'ЕдиницаИзмеренияНаименование' => "#{row[:ЕдИзм]}", 'КодКонтрагента' => "#{row[:Артикул]}"){}
				end
				
			}
		}
	}
	file = builder.to_xml
	send_data file, :type => 'text/xml; charset=UTF-8;', :disposition => "attachment; filename=Остатки на #{date}.xml"
  end
end
