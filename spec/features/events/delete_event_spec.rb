require 'rails_helper'

feature 'user deletes event' do
  ## Delete Event

# As a user
# I want to delete an event
# so I can remove cancelled obligations
#
# Acceptance Criteria
# [ ] Each event card will have a delete button.
# [ ] Delete button will prompt the use with "Are you sure?" With yes or no
#     options.
# [ ] Deleting an event in the middle of a list of events will prompt cards on
#     the right to shift left, closing the gap created by deleted card.

  let!(:event) { FactoryGirl.create(:event) }
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'exactly that' do
    date = event.start_time
    event_title = event.title
    login_as(user, scope: :user)
    visit event_path event
    click_link 'Delete'

    expect(page).to have_content date.strftime("%A %b %-d, %Y")
    expect(page).to_not have_content event_title
  end
end
