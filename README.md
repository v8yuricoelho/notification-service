
# Notification Service

## Description

The **Notification Service** handles notifications for the Task Manager system. It sends notifications to users when tasks are created, updated, or completed by communicating with other services in the system.

## Features

- Send notifications for task events.

## Technologies Used

- Ruby on Rails
- PostgreSQL
- ActionMailer for sending emails
- Shoryuken with AWS SQS for message processing

## Requirements

- **Ruby** 3.1.0 or higher
- **Rails** 7.0.0 or higher
- **PostgreSQL** 12 or higher
- **AWS SQS** configured for Shoryuken

## Environment Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/v8yuricoelho/notification-service.git
   cd notification-service
   ```

2. Install the dependencies:

   ```bash
   bundle install
   ```

3. Setup the database:

   ```bash
   rails db:create
   rails db:migrate
   ```

4. Set environment variables:

   Create a `.env` file in the project root with the following variables:

   ```bash
   AWS_ACCESS_KEY_ID=<your_aws_key>
   AWS_SECRET_ACCESS_KEY=<your_aws_secret>
   AWS_REGION=<your_aws_region>
   TASKS_QUEUE_URL=<your_aws_queue_url>
   STATUS_UPDATES_QUEUE_URL=<your_aws_queue_url>
   AUTH_SERVICE_URL=http://localhost:3001
   EMAIL_USER=<your_email>
   EMAIL_PASSWORD=<your_smtp_password>
   ```

5. Start the server and workers::

   ```bash
   rails server -p 3003
   ```

   Start Shoryuken to process AWS queues:

   ```bash
   bundle exec shoryuken -R -C config/shoryuken.yml -r ./app/workers -q <your_aws_queue_name>
   ```

## Testing

To run tests, use the command:

```bash
rspec
```

## Related Services

- [Task Manager](https://github.com/v8yuricoelho/task-manager)
- [Auth Service](https://github.com/v8yuricoelho/auth-service)
- [Scrape Service](https://github.com/v8yuricoelho/scrape-service)
