class PropertyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.user_type == 'landlord'
        scope.where(landlord: user)
      else
        scope.all
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
