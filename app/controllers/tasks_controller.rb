class TasksController < ApplicationController

  before_action :authenticate_user!, except: :show

  def new
    task = Task.new
    users = User.all
    statuses = Task.statuses
    render locals: { task: task,
                     users: users,
                     statuses: statuses }
  end

  def create
    task = Task.new(task_params)
    if task.save
      task.add_creator(current_user)
      redirect_to root_path
    else
      redirect_to new_task_path
    end
  end

  def edit
    task = find_task
    users = User.all
    assigned_users_ids = task.assigned_users.map(&:id)
    statuses = Task.statuses
    render locals: { task: task,
                     users: users,
                     statuses: statuses,
                     assigned_users_ids: assigned_users_ids }
  end

  def update
    task = find_task

    if task.update(task_params)
      task.add_creator(current_user)
      redirect_to task_path(task.id)
    else
      redirect_to edit_task_path(task.id)
    end
  end

  def show
    task = find_task
    users = task.users
    render locals: { task: task, users: users }
  end

  private

  def task_params
    params.require(:task).permit(:title,
                                 :description,
                                 :status,
                                 :start_date,
                                 :end_date,
                                 user_ids: [])
  end

  def find_task
    Task.find(params[:id])
  end

  def user_presence
    @alert = 'Please log in to edit tasks!'
    redirect_to root_path unless current_user.present?
  end
end
