require 'rails_helper'

feature 'user views month' do
# As a user
# I want to view a single month on my calendar
# so that I can see what days have events
#
# Acceptance Criteria
# [x] When a user accesses the root of the application, they should see an
#     overview of the current month.
# [ ] A user will see the current day highlighted.
# [ ] Days in partial weeks belonging to another month will be grayed out.
# [ ] Events will have indicator dots that tell the user whether their is an
#     event on that day (empty for no events, filled signifies 1 event or more).

  let!(:user) { FactoryGirl.create(:user) }

  10.times do |n|
    let!("event#{n}".to_sym) {FactoryGirl.create(:event) }
  end

  before(:each) do
    login_as(user, scope: :user)
    visit months_path
  end

  scenario 'and sees current months' do
    expect(page).to have_content Time.now.strftime("%B")
  end

  scenario 'and sees filled dots to indicate which days have events' do
    dates = [8, 11, 13, 15, 17, 18]
    dates
      .map { |n| page.find(:xpath, "//div[p[a[.='#{n}']]]") }
      .each { |element| expect(element.has_css?(".filled")).to be true }
  end

  scenario 'and sees what day it is' do
    day = Time.now.day
    element = page.find(:xpath, "//div[contains(concat(' ', normalize-space(@class), ' '), ' today ')]")

    expect(element.text).to eq day.to_s
  end

end
