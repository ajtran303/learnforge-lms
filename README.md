# LearnForge LMS

A lightweight Learning Management System built with Ruby on Rails. Track development progress on the [issues page](https://github.com/ajtran303/learnforge-lms/issues?q=is%3Aissue%20state%3Aopen%20sort%3Acreated-asc).

**Live demo:** [https://learnforge-lms.onrender.com](https://learnforge-lms.onrender.com)

## Overview

LearnForge LMS is a minimal, production-ready Learning Management System built with Ruby on Rails 8. It supports instructors and learners with role-based access, rich text lesson content, progress tracking, and course management.

This project demonstrates clean Rails architecture, Hotwire-driven interactivity, Action Text for rich content, and Test-Driven Development practices.

## Features

### Authentication & Roles

- Email/password authentication with bcrypt
- Role-based access: **Learner** and **Instructor**
- Protected routes and actions based on user role

### Course Management (Instructor)

- Create, edit, and delete courses
- Draft/published workflow for courses
- Rich text lesson editor with formatting toolbar
- Image attachments in lessons via Action Text
- Inline lesson editing with Turbo Frames

### Learning Experience (Learner)

- Browse published courses
- Enroll and unenroll from courses
- View course details and instructor info
- Mark lessons as completed
- Visual progress bar with resume functionality
- Lesson navigation with previous/next buttons and sidebar
- Unenrolling resets lesson completion progress

### Real-time Interactivity

- Turbo-powered updates without full-page reloads
- Instant enrollment/unenrollment feedback
- Dynamic lesson completion and progress updates
- Dismissible flash messages

## Tech Stack

- **Backend:** Ruby on Rails 8.1, PostgreSQL
- **Frontend:** Hotwire (Turbo + Stimulus), Bootstrap 5
- **Rich Text:** Action Text, Trix Editor, Active Storage
- **Authentication:** bcrypt (has_secure_password)
- **Testing:** RSpec, Capybara, FactoryBot, Shoulda Matchers
- **Deployment:** Render

## Setup

```bash
git clone git@github.com:ajtran303/learnforge-lms.git
cd learnforge-lms
bundle install
rails db:create db:migrate db:seed
rails server
```

Visit http://localhost:3000

### Dev Accounts

```
instructor1@example.com / password (Instructor)
instructor2@example.com / password (Instructor)
student@example.com / password (Learner)
```

## Running Tests

```bash
bundle exec rspec
```

Test coverage includes:

- Model validations and associations
- Course and lesson management
- Enrollment and unenrollment
- Lesson completion and progress tracking
- Role-based access control
- User authentication and registration

## License

MIT License
