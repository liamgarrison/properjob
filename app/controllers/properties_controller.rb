class PropertiesController < ApplicationController
  def new
    @property = Property.new
    authorize @property
  end
  
  def create

  end

  def show
    @property = Property.find(params[:id])
    authorize @property
  end
end
