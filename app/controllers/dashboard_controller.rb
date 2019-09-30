class DashboardController < ApplicationController
  def index
    tasks = Task.all.includes(:users)
    tasks_waiting_list = tasks.select(&:waiting_list?)
    tasks_in_progress = tasks.select(&:in_progress?)
    tasks_done = tasks.select(&:done?)
    @users = DashboardPolicy::Scope.new(current_user, User).resolve

    render locals: { tasks_done: tasks_done,
                     tasks_waiting_list: tasks_waiting_list,
                     tasks_in_progress: tasks_in_progress,
                     tasks: tasks }

  end
end
