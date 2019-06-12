class TenancyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Array of prefiltered tenancies coming from controller
      scope.select do |tenancy|
        user.owned_properties.include?(tenancy.property)
      end
    end
  end

  def new?
    # If the user owns the property for which the tenancy is being created
    user.owned_properties.include?(record.property)
  end

  def show?
    new?
  end

  def create?
    new?
  end

  def edit?
    new?
  end

  def update?
    new?
  end
end
