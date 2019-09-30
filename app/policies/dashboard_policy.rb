class DashboardPolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.present? && user.admin?
        scope.all
      else
        scope.where(role: 'user')
      end
    end
  end
end
