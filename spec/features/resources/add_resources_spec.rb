require 'rails_helper'

feature 'user can add resources to events' do
# As a user
# I want add an item to an event's resources list
# so that I can remember to have the resource for said event
#
# Acceptance criteria
# [x] The list show page will contain a new resource form at the the top of
#     the existing list(if any).
# [x] The form will consist of a quantity field and a dropdown to select
#     available pre-defined items available from invetory.
# [x] Upon successful form submission, the user will be redirected to the event
#     show page.

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }

  before(:each) do
    FactoryGirl.create(:inventory_item, name: "SM-58", category: "Sound")
    FactoryGirl.create(:inventory_item, name: "Source4 50deg 575w", category: "Lighting")
    login_as(user, scope: :user)
    visit event_path(event)
  end

  scenario 'successfully' do
    select "SM-58", from: 'Item'
    fill_in 'Quantity', with: 4
    click_button 'Add'

    expect(page).to have_content 'SM-58'
  end

  scenario 'unsuccessfully, missing quantity' do
    click_button 'Add'

    ul_elements = find_all(:xpath, "//ul")
    ul_elements.each { |element| expect(element).to_not have_content 'SM-58' }
    expect(page).to have_content "Quantity can't be blank"
  end
end
