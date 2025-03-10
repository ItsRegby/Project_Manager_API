# Project Management API

This is a Ruby on Rails API for managing projects and tasks. It includes features like user authentication, project management, task management, and caching for improved performance.

## Table of Contents

1. [Features](#features)
2. [Requirements](#requirements)
3. [Setup](#setup)
4. [Running the Application](#running-the-application)
5. [Running Tests](#running-tests)
6. [API Documentation](#api-documentation)
7. [Environment Variables](#environment-variables)
8. [Deployment](#deployment)

---

## Features

- **User Authentication**: JWT-based authentication for secure user login and registration.
- **Project Management**: Create, read, update, and delete projects.
- **Task Management**: Create, read, update, and delete tasks within projects.
- **Caching**: Redis-based caching for improved performance.
- **Testing**: Comprehensive test coverage with RSpec and Shoulda-Matchers.

---

## Requirements

Before setting up the project, ensure you have the following installed:

- **Ruby**: Version 3.4.2
- **Rails**: Version 8.0.1
- **Redis**: For caching
- **Bundler**: Version 2.6.5

---

## Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/ItsRegby/Project_Manager_API.git
   cd project_manager_api
   ```

2. **Install dependencies**:
   ```bash
   bundle install
   ```

3. **Set up the database**:
    - Run the following commands to set up the database:
      ```bash
      rails db:migrate
      ```

4. **Set up Redis**:
    - Ensure Redis is installed and running on your system.
    - Update the Redis configuration in `config/cache.yml` if needed.

5. **Set up environment variables**:
    - Create a `.env` file in the root directory and add the following variables:
      ```plaintext
      SECRET_KEY_BASE=your-secret-key-base
      REDIS_URL=redis://localhost:6379/1
      ```
    - Replace the placeholders with your actual values.

---

## Running the Application

1. **Start the Rails server**:
   ```bash
   rails server
   ```
   The API will be available at `http://localhost:3000`.

2. **Start Redis**:
   If Redis is not running, start it with:
   ```bash
   redis-server
   ```

3. **Access the API**:
   Use tools like [Postman](https://www.postman.com/) or [cURL](https://curl.se/) to interact with the API.

---

## Running Tests

To run the test suite, use the following command:

```bash
rspec
```

This will execute all unit, request, and service tests. Ensure the test database is set up:

```bash
rails db:test:prepare
```

---

## API Documentation

### Authentication

- **Register a new user**:
  ```plaintext
  POST /api/v1/auth/register
  Body: { "email": "user@example.com", "password": "password123", "password_confirmation": "password123" }
  ```

- **Login**:
  ```plaintext
  POST /api/v1/auth/login
  Body: { "email": "user@example.com", "password": "password123" }
  ```

### Projects

- **List all projects**:
  ```plaintext
  GET /api/v1/projects
  Headers: { "Authorization": "Bearer <JWT_TOKEN>" }
  ```

- **Create a project**:
  ```plaintext
  POST /api/v1/projects
  Headers: { "Authorization": "Bearer <JWT_TOKEN>" }
  Body: { "name": "New Project", "description": "Project description" }
  ```

- **Get project details**:
  ```plaintext
  GET /api/v1/projects/:id
  Headers: { "Authorization": "Bearer <JWT_TOKEN>" }
  ```

- **Update a project**:
  ```plaintext
  PUT /api/v1/projects/:id
  Headers: { "Authorization": "Bearer <JWT_TOKEN>" }
  Body: { "name": "Updated Project Name" }
  ```

- **Delete a project**:
  ```plaintext
  DELETE /api/v1/projects/:id
  Headers: { "Authorization": "Bearer <JWT_TOKEN>" }
  ```

### Tasks

- **List all tasks for a project**:
  ```plaintext
  GET /api/v1/projects/:project_id/tasks
  Headers: { "Authorization": "Bearer <JWT_TOKEN>" }
  ```

- **Create a task**:
  ```plaintext
  POST /api/v1/projects/:project_id/tasks
  Headers: { "Authorization": "Bearer <JWT_TOKEN>" }
  Body: { "name": "New Task", "description": "Task description", "status": "not_started" }
  ```

- **Update a task**:
  ```plaintext
  PUT /api/v1/projects/:project_id/tasks/:id
  Headers: { "Authorization": "Bearer <JWT_TOKEN>" }
  Body: { "name": "Updated Task Name", "status": "in_progress" }
  ```

- **Delete a task**:
  ```plaintext
  DELETE /api/v1/projects/:project_id/tasks/:id
  Headers: { "Authorization": "Bearer <JWT_TOKEN>" }
  ```

---

## Environment Variables

| Variable            | Description                          | Example Value                     |
|---------------------|--------------------------------------|-----------------------------------|
| `SECRET_KEY_BASE`   | Secret key for Rails application     | `your-secret-key-base`            |
| `REDIS_URL`         | Redis server URL                    | `redis://localhost:6379/1`        |

---

## Deployment

To deploy the application, follow these steps:

1. Set up a production environment (e.g., Heroku, AWS, DigitalOcean).
2. Configure environment variables in the production environment.
3. Run the following commands:
   ```bash
   rails assets:precompile
   rails db:migrate RAILS_ENV=production
   ```
4. Start the Rails server in production mode:
   ```bash
   rails server -e production
   ```