class DocumetsController < ApplicationController
  def show
  	#byebug
  	@lineitems = Lineitem.where(:document_id => params[:format])
  end
end
