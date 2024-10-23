# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StatusUpdateNotificationWorker, type: :worker do
  let(:task_data) do
    {
      'user_id' => 8,
      'task_id' => 114,
      'status' => 'completed',
      'url' => 'https://example.com'
    }.to_json
  end

  let(:user_email) { 'test@example.com' }

  before do
    allow_any_instance_of(StatusUpdateNotificationWorker).to receive(:fetch_user_email).and_return(user_email)
  end

  it 'sends a notification email when the task status is updated' do
    expect(NotificationMailer)
      .to receive(:status_updated)
      .with(hash_including('user_email' => user_email))
      .and_call_original

    StatusUpdateNotificationWorker.new.perform(nil, task_data)
  end
end
