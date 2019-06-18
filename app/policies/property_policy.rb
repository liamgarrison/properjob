class PropertyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(landlord: user)
    end
  end

  def index?
    user.user_type == 'landlord'
  end

  def new?
    user.user_type == 'landlord'
  end

  def create?
    new?
  end

  def show_tenancies?
    record.landlord == user
  end
end
