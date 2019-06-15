class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.select { |job| job.associated?(user) }
    end
  end

  def show?
    record.associated?(user)
  end

  def create?
    true
  end

  def new?
    create?
  end

  def show_messages?
    # For authorizing whether a user should be able to see job's messages
    record.associated?(user)
  end
end
