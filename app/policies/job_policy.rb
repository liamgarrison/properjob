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
    user.user_type == 'tenant'
  end

  def new?
    user.user_type == 'tenant'
  end

  def edit?
    record.associated?(user)
  end

  def update?
    record.associated?(user)
  end

  def show_messages?
    # For authorizing whether a user should be able to see job's messages
    record.associated?(user)
  end

  def create_payment?
    record.associated?(user) && user.user_type == 'landlord'
  end
end
