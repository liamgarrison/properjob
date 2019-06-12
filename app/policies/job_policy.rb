class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.properties.include?(record.property)
  end

  def create?
    true
  end

  def new?
    create?
  end
end
