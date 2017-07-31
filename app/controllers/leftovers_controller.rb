class LeftoversController < ApplicationController
  before_filter :authenticate_user! 
  def send_leftovers
	datato1c = Time.new(params[:start_date][:year].to_i,params[:start_date][:month].to_i,params[:start_date][:day].to_i,23,59,59).strftime("%Y%m%d%H%M%S")
	conn = Faraday.new "http://192.168.1.25/testalena/hs/ostatki/list/#{datato1c}"
	conn.basic_auth(ENV['USN'], ENV['PAS'])
	byebug
	body = conn.get.body
	result = JSON.parse(body)
	data = "#{params[:start_date][:day].to_i}.#{params[:start_date][:month].to_i}.#{params[:start_date][:year].to_i}"
	builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') { |xml|
		xml.Шапка('Составил' => '', 'ДатаСоставления' => "#{Time.now.strftime('%d.%m.%y %H:%M:%S')}", "ДатаСреза" => "#{data}") {
			xml.Склад('Наименование' => 'Склад КЛУ'){
				result.each do |row|

					xml.СтрокаНоменклатура('НоменклатураНаименование' => "#{row['Номенклатура']}",'Количество' => "#{row['Количество']}", 'ЕдиницаИзмеренияНаименование' => "#{row['ЕдИзм']}", 'КодКонтрагента' => ''){}
				end
				
			}
		}
	}
	file = builder.to_xml
	send_data file, :type => 'text/xml; charset=UTF-8;', :disposition => "attachment; filename=db.xml"
  end

end
