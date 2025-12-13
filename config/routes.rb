Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#show"

  get "/sign_up", to: "users#new", as: :new_user_registration
  post "/users", to: "users#create"

  get "/dashboard", to: "dashboard#show", as: :dashboard

  get "/sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create", as: :session
  delete "/logout", to: "sessions#destroy", as: :logout

  get "/courses/new", to: "courses#new", as: :new_course
  post "/courses", to: "courses#create", as: :courses
  get "/courses/:id", to: "courses#show", as: :course
  get "/courses/:id/edit", to: "courses#edit", as: :edit_course
  patch "/courses/:id", to: "courses#update"
  delete "/courses/:id", to: "courses#destroy"
  patch "/courses/:id/publish", to: "courses#publish", as: :publish_course
  patch "/courses/:id/unpublish", to: "courses#unpublish", as: :unpublish_course

  post "/courses/:id/enroll", to: "courses#enroll", as: :enroll_course

  get "/courses/:course_id/lessons/new", to: "lessons#new", as: :new_course_lesson
  post "/courses/:course_id/lessons", to: "lessons#create", as: :course_lessons
  get "/courses/:course_id/lessons/:id", to: "lessons#show", as: :course_lesson_show
  get "/courses/:course_id/lessons/:id/edit", to: "lessons#edit", as: :edit_course_lesson
  patch "/courses/:course_id/lessons/:id", to: "lessons#update", as: :course_lesson
  delete "/courses/:course_id/lessons/:id", to: "lessons#destroy"

  post "/courses/:course_id/lessons/:id/complete", to: "lesson_completions#create", as: :complete_course_lesson


  get "/admin", to: "admin#dashboard", as: :admin
end
