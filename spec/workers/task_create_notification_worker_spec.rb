# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskCreateNotificationWorker, type: :worker do
  let(:task_data) do
    {
      'user_id' => 8,
      'task_id' => 114,
      'status' => 'pending',
      'url' => 'https://example.com'
    }.to_json
  end

  let(:user_email) { 'test@example.com' }

  before do
    allow_any_instance_of(TaskCreateNotificationWorker).to receive(:fetch_user_email).and_return(user_email)
  end

  it 'sends a notification email when a task is created' do
    expect(NotificationMailer)
      .to receive(:task_created)
      .with(hash_including('user_email' => user_email))
      .and_call_original

    TaskCreateNotificationWorker.new.perform(nil, task_data)
  end
end
