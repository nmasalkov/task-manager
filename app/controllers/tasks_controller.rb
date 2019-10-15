class TasksController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_task, only: %i[edit update show]

  def new
    @task_form = TaskForm.new(current_user)
    @users = User.all
    @statuses = Task.statuses
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
    @task_form = TaskForm.new(current_user, {}, @task)
    @users = User.all
    @statuses = Task.statuses
  end

  def update
    @task_form = TaskForm.new(current_user, task_params, @task)
    if @task_form.save
      redirect_to task_path(@task)
    else
      redirect_to edit_task_path(@task)
    end
  end

  def show
    @users = @task.users
  end

  private

  def task_params
    task_params = params.require(:task).permit(:title,
                                                :description,
                                                :status,
                                                :start_date,
                                                :end_date,
                                                user_ids: [])

    NormalizeDatesService.new(task_params).normalize_date_attr
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
