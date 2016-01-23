require 'rails_helper'

feature 'user can create events' do
# As a user
# I want to be able to create an event
# so that I can keep track of obligations
#
# Acceptance Criteria
# [x] The new event form will have the same visual footprint as an event card,
#     and will be located in the event pane, to the right of existing events if
#     any.
# [x] A start time must be before an end time.
# [x] Title cannot be blank.
# [x] Description is optional.
# [ ] Form will contain 'time helpers' (ie, the application will translate '11a'
#     typed in by the user to '11:00 AM', or whatever format it needs)
# [ ] Upon successful form submission, a page reload will not happen, instead
#     the form will be replaced with the new event card.

  let!(:user) { FactoryGirl.create(:user) }
  let!(:datetime) { DateTime.new(2016, 01, 20, 8, 0, 0) }

  before(:each) do
    login_as(user, scope: :user)
    visit months_path
    click_link '20'
  end

  scenario 'successfully, with date selected' do
    fill_in 'Title', with: 'GE Conference'
    fill_in 'Description', with: 'Setup lighting package #1, sound package #2'

    fill_in 'Start Time', with: datetime
    fill_in 'End Time', with: (datetime + 3.hours)
    click_button 'Create'

    expect(page).to have_content 'GE Conference'
  end

  scenario 'unsuccessfully due to empty required parameters' do
    click_button 'Create'

    expect(page).to have_content 'Title can\'t be blank'
    expect(page).to have_content 'Start time is not a valid date'
    expect(page).to have_content 'End time is not a valid date'
  end

  scenario 'unsuccessfully due to event start time occuring after event end time' do

    fill_in 'Title', with: 'Donor Banquet'
    fill_in 'Description', with: 'Lots o tables and chairs'
    fill_in 'Start Time', with: datetime
    fill_in 'End Time', with: (datetime - 1.hours)
    click_button 'Create'

    expect(page).to have_content 'Sorry, you can\'t create an event that ends before it starts.'
  end
end
