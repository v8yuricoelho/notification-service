# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe NotificationMailer, type: :mailer do
  let(:task) do
    {
      'user_email' => 'test@example.com',
      'url' => 'https://example.com',
      'status' => 'pending',
      'task_id' => 1
    }
  end

  describe 'task_created' do
    let(:mail) { NotificationMailer.task_created(task) }

    it 'renders the headers' do
      expect(mail.subject).to eq('New Task Created')
      expect(mail.to).to eq([task['user_email']])
      expect(mail.from).to eq(['no-reply@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(task['url'])
    end
  end

  describe 'status_updated' do
    let(:mail) { NotificationMailer.status_updated(task) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Task Status Updated')
      expect(mail.to).to eq([task['user_email']])
      expect(mail.from).to eq(['no-reply@example.com'])
    end

    it 'renders the body with task status and task ID' do
      expect(mail.body.encoded).to include(task['status'])
      expect(mail.body.encoded).to include(task['task_id'].to_s)
    end
  end
end
# rubocop:enable Metrics/BlockLength
