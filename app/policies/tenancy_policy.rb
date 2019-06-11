class TenancyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(property: user.owned_properties)
    end
  end

  def new?
    # If the user owns the property for which the tenancy is being created
    user.properties.include?(record.property)
  end

  def create?
    new?
  end
end
