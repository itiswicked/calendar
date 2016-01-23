require 'rails_helper'

feature 'user edits events' do
# As a user
# I want to edit and event
# so I can update an events information
#
# Acceptance Criteria
# [x] Each event card will have an edit button. Eventually, This will transform
#     the card back to an autofilled form
# [x] Each event edit will have all the typical attributes to be updated,
#     plus the ability to change the day that the event is on.
# [ ] Upon successful form submission, the form crd is transformed back into
#     an event card, or in the case that the day of the event changes,
#     disappears to another day.

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }
  let!(:datetime) { event.start_time }

  scenario 'successfully, redirects to event show page' do
    login_as(user, scope: :user)
    visit event_path(event)
    click_link 'Edit'

    title_value = find_by_id("event_title").value
    expect(title_value).to eq event.title

    description_value = find_by_id("event_description").value
    expect(description_value).to eq event.description

    start_time_value = find_by_id("event_start_time").value
    expect(start_time_value).to eq event.start_time.strftime("%Y-%m-%dT%H:%M:%S")

    end_time_value = find_by_id("event_end_time").value
    expect(end_time_value).to eq event.end_time.strftime("%Y-%m-%dT%H:%M:%S")

    fill_in 'Title', with: 'GE Conference'
    fill_in 'Description', with: 'Setup lighting package #1, sound package #2'
    fill_in 'Start Time', with: datetime
    fill_in 'End Time', with: (datetime + 3.hours)
    click_button 'Create'

    expect(page).to have_content 'GE Conference'
    expect(page.current_path).to eq "/events/1"
  end
end
