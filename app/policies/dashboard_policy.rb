# frozen_string_literal: true

class DashboardPolicy < ApplicationPolicy
  def create_task?
    user.present?
  end
end
