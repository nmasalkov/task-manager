class TaskMailer < ApplicationMailer
  def new_assignment_task_email(task, user)
    @task = task
    @user = user

    mail(to: 'nikitamasalkov.tang@gmail.com',
         subject: 'User\'s been applied to task')
  end

  def new_unassignment_task_email
    @task = params[:task]
    @user = params[:user]

    mail(to: 'nikitamasalkov.tang@gmail.com',
         subject: 'User\'s been unassigned from task')
  end

end
