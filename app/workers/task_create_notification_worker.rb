# frozen_string_literal: true

class TaskCreateNotificationWorker
  include Shoryuken::Worker

  shoryuken_options queue: 'tasks_queue', auto_delete: false

  def perform(_sqs_msg, body)
    task = JSON.parse(body)
    user_email = fetch_user_email(task['user_id'])
    NotificationMailer.task_created(task.merge('user_email' => user_email)).deliver_now
  end

  private

  def fetch_user_email(user_id)
    auth_service_url = ENV['AUTH_SERVICE_URL']
    response = Faraday.get("#{auth_service_url}/users/#{user_id}")
    JSON.parse(response.body)['email']
  end
end
