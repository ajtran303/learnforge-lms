# LearnForge LMS (Ruby on Rails)

A lightweight Learning Management System built as a full-stack Rails MVP. Track dev progress on the [issues page](https://github.com/ajtran303/learnforge-lms/issues?q=is%3Aissue%20state%3Aopen%20sort%3Acreated-asc).

Visit the app in production at: [https://learnforge-lms.onrender.com](https://learnforge-lms.onrender.com)

---

## 🚀 Overview

LearnForge LMS is a minimal, production-ready Learning Management System built with Ruby on Rails 8. It supports instructors and learners with role-based access, lesson progress tracking, and course management.

This project demonstrates clean Rails architecture, modern Hotwire-driven interactivity, role-based access control, and professional full-stack development practices including Test-Driven Development (TDD).

---

## 🧩 Features

### 👤 Authentication & Roles
- Email/password authentication using `bcrypt`
- Roles: **Learner**, **Instructor**, and **Admin**
- Role-based access control throughout the app

### 📚 Course Management (Instructor)
- Create, edit, and delete courses
- Draft/published workflows for courses
- Add, edit, and delete lessons with text content
- Instructor dashboard showing draft and published courses
- Inline lesson editing with Turbo frames

### 🎓 Learning Experience (Learner)
- Browse published courses only
- Enroll in courses with one click
- View course details and instructor info
- Mark lessons as completed
- Visual course progress bar and last-lesson tracking
- Navigate lessons with previous/next buttons and sidebar

### 🔄 Real-time Interactivity
- Turbo-powered updates for lessons, lesson completion, and course progress
- Forms update dynamically without full-page reloads

---

## ⚙️ Tech Stack

- **Backend:** Ruby on Rails 8.1
- **Database:** PostgreSQL
- **Frontend:** Turbo, Bootstrap 5
- **Authentication:** `has_secure_password` (bcrypt)
- **Testing:** RSpec, Capybara, Shoulda Matchers
- **Deployment:** Render

---

## 🏗️ Architecture

**Backend**
- RESTful Rails controllers
- Model validations and associations
- PostgreSQL schemas with foreign keys and constraints

**Frontend**
- Turbo for SPA-like navigation and partial updates
- Bootstrap for responsive styling
- Turbo frames for inline forms and updates

---

## ⚡ Setup

```bash
git clone <repo_url>
cd learnforge-lms
bundle install
rails db:create db:migrate db:seed
rails server
```

Visit http://localhost:3000

Login with any of the following users:

```
instructor1@example.com    password
instructor2@example.com    password
student@example.com        password
```

## 🧪 Running Tests
```bash
bundle exec rspec
```

Includes model, system, and integration tests for:
- Courses, lessons, and enrollment
- Lesson completion and course progress
- Role-based access control
- Authentication and user registration

## 🤝 Contributing

This is a solo portfolio project, but contributions and issues are welcome.

## 📄 License

MIT License

## ⭐ Support

If you find this project helpful or interesting, please consider starring ⭐ the repository!
