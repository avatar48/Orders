class PartnersController < ApplicationController
  before_action :set_partner, only: [:show, :edit, :destroy]
  def index
    @partners = Partner.all
  end

  def edit

  end

  def new
    @partner = Partner.new 
  end

  def create
    @partner = Partner.new(partner_params)     
        respond_to do |format|
          if @partner.save
            format.html { redirect_to partners_path, notice: "Контрагент #{@partner.name} успешно создан." }
            format.json { render :index, status: :created, location: @partner }
          else
            format.html { render :new }
            format.json { render json: @partner.errors, status: :unprocessable_entity }
          end
        end
  end

  def destroy
    @partner.destroy
    respond_to do |format|
      format.html { redirect_to partners_url, notice: "Контрагент #{@partner.name} удален." }
      format.json { head :no_content }
    end
  end


  private
  def set_partner
    @partner = Partner.find(params[:id])
  end

  def partner_params
    params.require(:partner).permit(:name, :inn, :kpp)
  end

end
