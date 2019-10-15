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
    task.set_creator(current_user)
    if task.save
      redirect_to root_path
    else
      redirect_to new_task_path
    end
  end

  def edit
    task = find_task
    users = User.all
    statuses = Task.statuses
    render locals: { task: task,
                     users: users,
                     statuses: statuses }
  end

  def update
    task = find_task

    if task.update(task_params)
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
end
