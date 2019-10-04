class DashboardController < ApplicationController
  def index
    tasks = Task.all.includes(:users)
    tasks_waiting_list = tasks.select(&:waiting_list?)
    tasks_in_progress = tasks.select(&:in_progress?)
    tasks_done = tasks.select(&:done?)
    users = User.all
    regular_users = users.select(&:user?)
    admin_users = users.select(&:admin?)
    render locals: { tasks_done: tasks_done,
                     tasks_waiting_list: tasks_waiting_list,
                     tasks_in_progress: tasks_in_progress,
                     tasks: tasks, regular_users: regular_users,
                     admin_users: admin_users }
  end
end
