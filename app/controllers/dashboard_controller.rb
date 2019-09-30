class DashboardController < ApplicationController
  def index
    tasks = Task.all.includes(:users)

    tasks_waiting_list = tasks.select(&:waiting_list?)
    tasks_in_progress = tasks.select(&:in_progress?)
    tasks_done = tasks.select(&:done?)
    @users = policy_scope(User)
    admin_users = @users.select(&:admin?)
    regular_users = @users.select(&:user?)
    render locals: { tasks_done: tasks_done,
                     tasks_waiting_list: tasks_waiting_list,
                     tasks_in_progress: tasks_in_progress,
                     tasks: tasks,
                     admin_users: admin_users,
                     regular_users: regular_users }
  end
end
