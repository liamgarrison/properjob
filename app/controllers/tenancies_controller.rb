class TenanciesController < ApplicationController
  def index
    @tenancies = policy_scope Tenancy
  end

  def show
  end

  def new
    @tenancy = Tenancy.new
    @tenancy.property = Property.find(params[:property_id])
    authorize @tenancy
  end

  def create
  end
end
