# frozen_string_literal: true

class TasksController < ApplicationController
  def new
    @task = Task
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

  private

  def task_params
    params.require(:task).permit(:title, :description, :status, user_ids: [])
  end
end
