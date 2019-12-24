# frozen_string_literal: true

class TaskMailer < ApplicationMailer
  def new_assignment_task_email(task, user)
    @task = task
    @user = user
    sleep 40
    logger.info('Sent assignment task from assignment queue')

    mail(to: 'nikitamasalkov.tang@gmail.com',
         subject: 'User\'s been applied to task')
  end

  def new_unassignment_task_email(task, user)
    @task = task
    @user = user
    sleep 40

    mail(to: 'nikitamasalkov.tang@gmail.com',
         subject: 'User\'s been unassigned from task')
    logger. warn('Sent UNassignment task from UNassignment queue')
  end
end
