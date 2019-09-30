class DashboardController < ApplicationController
  def index
    tasks = Task.all.includes(:users)
    tasks_waiting_list = tasks.select { |task| task.status == 'waiting_list' }
    tasks_in_progress = tasks.select { |task| task.status == 'in_progress' }
    tasks_done = tasks.select { |task| task.status == 'done' }
    users = User.all
    regular_users = users.select { |user| user.role == 'user' }
    admin_users = users.select { |user| user.role == 'admin' }
    render locals: { tasks_done: tasks_done, tasks_waiting_list: tasks_waiting_list, tasks_in_progress: tasks_in_progress, tasks: tasks, regular_users: regular_users, admin_users: admin_users }
  end
end
