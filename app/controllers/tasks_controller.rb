class TasksController < ApplicationController
  before_action :authenticate_user!, except: :show

  def new
    @task_form = TaskForm.new(current_user)
    users = User.all
    statuses = Task.statuses
    render locals: { users: users, statuses: statuses }
  end

  def create
    @task_form = TaskForm.new(current_user, task_params)
    if @task_form.save
      redirect_to root_path
    else
      redirect_to new_task_path
    end
  end

  def edit
    @task = find_task
    @task_form = TaskForm.new(current_user, {}, @task)
    users = User.all
    statuses = Task.statuses
    render locals: { users: users, statuses: statuses }
  end

  def update
    @task = find_task
    @task_form = TaskForm.new(current_user, task_params, @task)
    if @task_form.save
      redirect_to task_path(@task)
    else
      redirect_to edit_task_path(@task)
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
