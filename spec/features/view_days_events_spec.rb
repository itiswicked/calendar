require 'rails_helper'

feature 'user views days events' do
# As a user
# I want to view a days event's
# so that I can plan my day
#
# Acceptance Criteria
# [ ] A user will click on a day, and a pane will open up, splitting the
#     calendar grid. Calendar grid will split just under the selected day,
#     pushing rest of calendar grid downward).
# [ ] Clicking on the same day will close the event pane
# [ ] Clicking on a day in the same row will not close the pane, but rather
#     information will simply be replaced.
# [ ] Clicking on a day in a different week will slide the current pane closed
#     and open a new one under the new row.
# [ ] The pane will contain cards, each with one event's info on it.

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }

  scenario 'by clicking on a day in calendar' do
    login_as(user, scope: :user)
    visit months_path
save_and_open_page
    click_link event.start_time.day

    expect(page).to have_content event.title
    expect(page).to have_content event.description
  end
end
