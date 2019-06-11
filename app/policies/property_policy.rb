class PropertyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    user.user_type == 'landlord'
  end

  def create?
    new?
  end
end
