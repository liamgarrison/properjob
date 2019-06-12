class PropertiesController < ApplicationController
  def index
    @properties = policy_scope Property
  end

  def new
    @property = Property.new
    authorize @property
  end
  
  def create
    @property = Property.new(property_params)
    @property.landlord = current_user
    authorize @property
    if @property.save
      redirect_to properties_path
    else
      render :new
    end
  end

  def show
    @property = Property.find(params[:id])
    authorize @property
  end

  def property_params
    params.require(:property).permit(:address)
  end
end
