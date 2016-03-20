require 'rails_helper'

feature 'user signs in' do
# As a user
# I want to be able to sign in
# so that I can manage my own calendar
#
# Acceptance Criteria
# [ ] At the the root of the application, a user will see a sign in form.
# [ ] Users will sign in with their username and password.
# [ ] Upon successful authentication, a user is directed to their own calendar.
# [ ] When unsuccessful, is directed to the same page, with appropriate errors
#     displayed.

  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    visit '/'
  end

  scenario 'is successful' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    within('.login-form') do
      click_button 'Sign in'
    end

    expect(page.current_path).to eq '/months'
    expect(page).to have_content 'Signed in successfully'
    expect(page).to_not have_content 'Log In'
    expect(page).to_not have_content 'Sign Up'
  end

  scenario 'has incorrect email or password' do
    fill_in 'Email', with: 'incorrect_email@mail.com'
    fill_in 'Password', with: 'incorrect_password'
    within('.login-form') do
      click_button 'Sign in'
    end

    expect(page.current_path).to eq '/users/sign_in'
    expect(page).to have_content "Invalid email or password."
  end

end
