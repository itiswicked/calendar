require 'rails_helper'

feature 'user views other months' do

# As a user
# I want to view other months
# so that I can look ahead in time and behind
#
# Acceptance Criteria
# [ ] A user will see left pointing arrow at the top of the page for navigating
#     to previous month.
# [ ] A user will see right pointing arrow at the top of the page for navigating
#     to the next month.
# [ ] These navigation elements ideally will not illicit another page load,
#     but rather JS will repopulate the page with the correct info.

  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login_as(user)
    visit months_path
  end

  scenario 'the previous month' do
    click_link 'Last'
    last_month = (Time.now - 1.month)

    expect(page).to have_content last_month.strftime("%B")
    expect(page).to have_content last_month.year
  end

  scenario 'the next month' do
    click_link 'Next'
    next_month = (Time.now + 1.month)

    expect(page).to have_content next_month.strftime("%B")
    expect(page).to have_content next_month.year
  end

end
