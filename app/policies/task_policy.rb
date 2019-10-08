class TaskPolicy < ApplicationPolicy

  def edit?
    creator? || assigned?
  end

  def creator?
    @user == @record.creator
  end

  def assigned?
    @record.assigned_users.include?(@user)
  end
end
