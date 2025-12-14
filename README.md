# LearnForge LMS (Ruby on Rails)

A lightweight Learning Management System built as a full-stack Rails MVP. Track dev progress on the [issues page](https://github.com/ajtran303/learnforge-lms/issues?q=is%3Aissue%20state%3Aopen%20sort%3Acreated-asc).

Visit the app in production at: [https://learnforge-lms.onrender.com](https://learnforge-lms.onrender.com)

## 🚀 Overview

LearnForge is a minimal, production-ready Learning Management System built with Ruby on Rails 8. It features course creation, lesson management, enrollment, and progress tracking.

This project is built to demonstrate clean Rails architecture, role-based access control, modern Hotwire-driven interactivity, and professional full-stack development practices such as Test-Driven Development.

## 🧩 Features (MVP)
- 👤 Authentication & Roles

- Email/password authentication

- Roles: Learner, Instructor, Admin

📚 Course Management (Instructor)

- Create, edit, delete courses

- Add lessons with text content

- Draft/published workflows

- Instructor dashboard

🎓 Learning Experience (Learner)

- Browse published courses

- Enroll with one click

- View lessons

- Mark lessons complete

- Progress bar + last lesson tracking

🛠️ Admin Tools

- View all courses

- Unpublish inappropriate content

- View/disable users

## ⚙️ Tech Stack

- Ruby on Rails 8

- RSpec

- PostgreSQL

- Hotwire (Turbo + Stimulus)

- Tailwind CSS

- Render or Fly.io deployment (TBD)

There are no file uploads or media attachments in this MVP.

## 🏗️ Architecture
Backend

- RESTful Rails controllers

- Service Objects for logic (enrollments, progress updates)

- PostgreSQL schemas with foreign keys + constraints

Frontend

- Turbo for navigation and partial updates

- Stimulus for interactivity (progress tracking, lesson UI)

- Tailwind CSS for styling

## 🤝 Contributing

This is a solo portfolio project, but contributions and issues are welcome.

## 📄 License

MIT License

## ⭐ Support

If you find this project helpful or interesting, please consider starring ⭐ the repository!
