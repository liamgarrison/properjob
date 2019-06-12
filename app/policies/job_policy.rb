class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case user.user_type
      when 'tenant'
        scope.where(tenancy: user.current_tenancy)
      when 'landlord'
        scope.all.select { |job| user.owned_properties.include?(job.tenancy.property) }
      end
    end
  end

  def show?
    user.tenancies.include?(record.tenancy)
  end

  def create?
    true
  end

  def new?
    create?
  end
end
