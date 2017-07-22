class LeftoversController < ApplicationController
  before_filter :authenticate_user! 
  def send_leftovers
  	@a = TinyTds::Client.new(:adapter => "sqlserver", :host => ENV['HOST'], :username => ENV['USN'], :password => ENV['PAS'], :database => ENV['DB'])
	data = "#{params[:start_date][:day].to_i}.#{params[:start_date][:month].to_i}.#{params[:start_date][:year].to_i}"
	sql = "SELECT
	LG_001_ITEMS.LOGICALREF AS [SREF],
	LG_001_UNITSETF.LOGICALREF AS [USEF],
	LG_001_ITEMS.CODE AS [ITEM CODE],
	LG_001_UNITSETF.CODE AS [UNIT CODE],
	SUM (LG_001_01_STINVTOT.ONHAND)AS [STOCK],
	SUM (LG_001_01_STINVTOT.RESERVED)AS [RESERVED],
	(SUM (LG_001_01_STINVTOT.ONHAND) -SUM (LG_001_01_STINVTOT.RESERVED)) AS TOTAL,
	LG_001_ITEMS.NAME AS [NAME]
	FROM LG_001_ITEMS WITH(NOLOCK, INDEX = I001_ITEMS_I1)
	INNER JOIN LG_001_01_STINVTOT WITH(NOLOCK, INDEX = I001_01_STINVTOT_I2)ON LG_001_ITEMS.LOGICALREF = LG_001_01_STINVTOT.STOCKREF
	INNER JOIN  LG_001_UNITSETF WITH(NOLOCK, INDEX =  I001_UNITSETF_I1)ON LG_001_ITEMS.UNITSETREF =  LG_001_UNITSETF.LOGICALREF
	WHERE INVENNO = 9 AND LG_001_ITEMS.CARDTYPE IN (1,12) AND
	LG_001_01_STINVTOT.DATE_ > CONVERT(dateTime, '5-19-1919', 101)AND LG_001_01_STINVTOT.DATE_ < CONVERT(dateTime, '#{data}', 104)AND
	LG_001_ITEMS.ACTIVE = 0
	GROUP BY LG_001_ITEMS.LOGICALREF,LG_001_UNITSETF.LOGICALREF,LG_001_ITEMS.CODE,LG_001_ITEMS.NAME,LG_001_UNITSETF.CODE
	ORDER BY LG_001_ITEMS.CODE"
	result = @a.execute(sql)
	builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') { |xml|
		xml.Шапка('Составил' => '', 'ДатаСоставления' => "#{Time.now.strftime('%d.%m.%y %H:%M:%S')}", "ДатаСреза" => "#{data}") {
			xml.Склад('Наименование' => 'Склад КЛУ'){
				result.each do |row|
					xml.СтрокаНоменклатура('НоменклатураНаименование' => "#{row['NAME']}",'Количество' => "#{row['TOTAL']}", 'ЕдиницаИзмеренияНаименование' => "#{row['UNIT CODE']}", 'КодКонтрагента' => ''){}
				end
				
			}
		}
	}
	file = builder.to_xml
	send_data file, :type => 'text/xml; charset=UTF-8;', :disposition => "attachment; filename=db.xml"
  end

end
