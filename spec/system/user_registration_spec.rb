require "rails_helper"

RSpec.describe "User Registration", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:existing_user_email) { "existing@example.com" }

  context "with valid details" do
    it "allows a new learner to sign up with valid details" do
      visit new_user_registration_path

      fill_in "Email", with: "learner@example.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"

      click_button "Sign Up"

      user = User.find_by(email: "learner@example.com")
      expect(user.role).to eq("learner")

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content("Welcome, learner@example.com!")
    end
  end

  context "with invalid details" do
    it "shows errors when the form is invalid" do
      visit new_user_registration_path

      fill_in "Email", with: ""
      fill_in "Password", with: ""
      click_button "Sign Up"

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end

    it "shows an error when password confirmation does not match" do
      visit new_user_registration_path

      fill_in "Email", with: "newuser@example.com"
      fill_in "Password", with: "password123"
      fill_in "Password confirmation", with: "wrongpassword"
      click_button "Sign Up"

      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it "shows an error when email is already taken" do
      FactoryBot.create(:user, email: existing_user_email)

      visit new_user_registration_path

      fill_in "Email", with: existing_user_email
      fill_in "Password", with: "password1"
      fill_in "Password confirmation", with: "password1"
      click_button "Sign Up"

      expect(page).to have_content("Email has already been taken")
    end
  end
end
