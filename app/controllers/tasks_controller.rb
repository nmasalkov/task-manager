class TasksController < ApplicationController
  def new
    @task_class = Task
    @users = User.all
    @statuses = Task.statuses
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
    else
      redirect_to new_task_path
    end
  end

  def edit
    task = find_task
    @task_class = Task
    @users = User.all
    @statuses = Task.statuses
    render locals: { task: task }
  end

  def update
    task = find_task
    task.update(task_params)
    if task.save
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
