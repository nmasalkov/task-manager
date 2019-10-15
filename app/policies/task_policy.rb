class TaskPolicy < ApplicationPolicy

  def edit?
    creator? || assigned?
  end

  def creator?
    @user == @record.creator
  end

  def assigned?
    @record.users.include?(@user)
  end
end
