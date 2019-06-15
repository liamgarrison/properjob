class JobPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      case user.user_type
      when 'tenant'
        scope.where(tenancy: user.current_tenancy)
      when 'landlord'
        scope.all.select { |job| user.owned_properties.include?(job.tenancy.property) }
      when 'contractor'
        scope.all.select do |job|
          # Find the quotes where submitted is nil (pending) or it has been accepted
          pending_or_accepted_quotes = job.quotes.select { |quote| quote.accepted || quote.submitted.nil? }
          contractors_who_see_job = pending_or_accepted_quotes.map(&:contractor)
          contractors_who_see_job.include?(user)
        end
      end
    end
  end

  def show?
    case user.user_type
    when 'tenant'
      record.tenancy == user.current_tenancy
    when 'landlord'
      user.owned_properties.include?(record.tenancy.property)
    when 'contractor'
      # Find the quotes where submitted is nil (pending) or it has been accepted
      pending_or_accepted_quotes = record.quotes.select { |quote| quote.accepted || quote.submitted.nil? }
      contractors_who_see_job = pending_or_accepted_quotes.map(&:contractor)
      contractors_who_see_job.include?(user)
    end
  end

  def create?
    true
  end

  def new?
    create?
  end
end
