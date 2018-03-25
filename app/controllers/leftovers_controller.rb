class LeftoversController < ApplicationController
  before_filter :authenticate_user! 
	def send_leftovers
		datato1c = Time.new(params[:start_date][:year].to_i,params[:start_date][:month].to_i,params[:start_date][:day].to_i).strftime("%Y-%m-%d")
		client = Savon.client(wsdl: 'http://192.168.1.25/PV/ws/ws1.1cws?wsdl', basic_auth: [ENV['USN1C'], ENV['PAS']])
		x = client.call(:hello_baza, message: {zapros: datato1c}).to_hash
		result = x[:hello_baza_response][:return][:НоменклатураСписка]
	 	data = "#{params[:start_date][:day].to_i}.#{params[:start_date][:month].to_i}.#{params[:start_date][:year].to_i}"
		builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') { |xml|
		xml.Шапка('Составил' => '', 'ДатаСоставления' => "#{Time.now.strftime('%d.%m.%y %H:%M:%S')}", "ДатаСреза" => "#{data}") {
			xml.Склад('Наименование' => 'Склад КЛУ'){
				result.map do |row|

					xml.СтрокаНоменклатура('НоменклатураНаименование' => "#{row[:Наименование]}",'Количество' => "#{row[:Количество]}", 'ЕдиницаИзмеренияНаименование' => "#{row[:ЕдИзм]}", 'Артикул' => "#{row[:Артикул]}", 'КодКонтрагента' => ''){}
				end
				
			}
		}
	}
	file = builder.to_xml
	send_data file, :type => 'text/xml; charset=UTF-8;', :disposition => "attachment; filename=db.xml"
  end
end
