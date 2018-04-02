class LeftoversController < ApplicationController
  before_filter :authenticate_user! 
	def send_leftovers
		leftovers = Leftovers.new(params[:start_date])
		leftovers.conect
		file = leftovers.to_xml
		send_data file, :type => 'text/xml; charset=UTF-8;', :disposition => "attachment; filename=Остатки на #{leftovers.date}.xml"
	end
end
