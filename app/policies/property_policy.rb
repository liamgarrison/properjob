class PropertyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case user.user_type
      when 'landlord'
        scope.where(landlord: user)
      when 'tenant'
        scope.all.select do |property|
          property.tenants.include? user
        end
      end
    end
  end

  def new?
    user.user_type == 'landlord'
  end

  def create?
    new?
  end
end
