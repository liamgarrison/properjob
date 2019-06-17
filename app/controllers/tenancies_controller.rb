class TenanciesController < ApplicationController
  after_action :verify_authorized, only: :index

  def index
    @property = Property.find(params[:property_id])

    # Scope based on user
    @tenancies = policy_scope Tenancy
    @tenancies = @tenancies.select { |tenancy| tenancy.property == @property }.sort_by(&:end_date).reverse

    authorize @property, :show_tenancies?
  end

  def new
    @property = Property.find(params[:property_id])
    @tenancy = Tenancy.new
    @tenancy.property = @property
    authorize @tenancy
  end

  def create
    @property = Property.find(params[:property_id])
    @tenancy = Tenancy.new(tenancy_params)
    @tenancy.property = @property
    authorize @tenancy
    if @tenancy.save
      redirect_to property_tenancies_path
    else
      render :new
    end
  end

  private

  def tenancy_params
    params.require(:tenancy).permit(:start_date, :end_date, :deposit, :deposit_refunded, :rent_amount, tenant_ids: [])
  end
end
