require "rails_helper"

RSpec.describe "User Login", type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:user) { FactoryBot.create(:user, email: "user@example.com", password: "password") }

  it "logs in with valid credentials" do
    visit new_session_path

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"

    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_content("Logged in successfully!")
  end

  it "shows an error with invalid credentials" do
    visit new_session_path

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "wrong"
    click_button "Sign In"

    expect(page).to have_content("Invalid email or password")
  end

  it "logs out successfully" do
    visit new_session_path

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"

    click_button "Log out"

    expect(page).to have_current_path(new_session_path)
    expect(page).to have_content("Logged out successfully!")
  end
end
