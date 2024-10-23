# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def task_created(task)
    @task = task
    mail(to: task['user_email'], subject: 'New Task Created')
  end

  def status_updated(task)
    @task = task
    mail(to: task['user_email'], subject: 'Task Status Updated')
  end
end
