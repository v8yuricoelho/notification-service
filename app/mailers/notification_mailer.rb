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

  private

  def fetch_user_email(user_id)
    response = Faraday.get("https://auth-service-url/users/#{user_id}")
    JSON.parse(response.body)['email']
  end
end
