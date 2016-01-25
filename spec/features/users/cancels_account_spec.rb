require 'rails_helper'

feature 'user cancels account' do
  ## Cancel Account
# As a user
# I want to cancel my account
# because I no longer want to use the service
#
# Acceptance Criteria
# [x] In the nav, there will be a button for cancelling an account
# [x] When the button is clicked, the current user is logged out
# [x] The user is deleted from the database and will no longer be able to sign
#     in.

  let!(:user) { FactoryGirl.build(:user) }

  scenario 'user successfully cancels account, cannot access calendar' do
    user.save
    login_as(user, scope: :user)
    visit months_path
    click_link 'Cancel Account'
    expect(page.current_path).to eq '/'
    expect(page).to have_content "Your account has been successfully cancelled."

    fill_in "Email", with: user.email
    fill_in "Password", with: 'password'
    click_button "Log in"

    expect(page).to have_content "Invalid email or password."
  end

end
