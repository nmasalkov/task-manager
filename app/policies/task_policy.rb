class TaskPolicy < ApplicationPolicy

  def creator?
    @user == @record.creator
  end
end
