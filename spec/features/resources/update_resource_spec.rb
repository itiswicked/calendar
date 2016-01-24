require 'rails_helper'

feature 'user updates resource' do
# As a user
# I want to update my list items
# so the list reflects my ever changing needs
#
# Acceptance Criteria
# [x] Every list item will contain an 'Edit' button.
# [ ] When clicked, ideally the form appears in the same place as the list item.
# [x] Update will allow you to change quantity only (much like a shopping cart).
# [ ] When the form is submitted, ideally the form goes away and is replaced with the newly updated item.

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }
  let!(:inventory_items) do
    [
      FactoryGirl.create(:inventory_item, name: 'SM-58', category: 'Sound'),
      FactoryGirl.create(:inventory_item, name: 'Source4 50deg 575w', category: 'Lighting')
    ]
  end

  let!(:resource) do
    FactoryGirl.create(
      :resource,
      event: event,
      inventory_item: inventory_items[0]
    )
  end

  before(:each) do
    login_as(user, scope: :user)
    visit event_path(event)
    within(".resource") { click_link 'Edit' }
  end

  scenario 'successfully' do
    fill_in 'Quantity', with: 50
    click_button 'Submit'

    ul_elements = find_all(:xpath, "//ul")
    ul_elements.each do |element|
      expect(element).to_not have_content '4'
      expect(page).to have_content '50'
    end
    expect(page.current_path).to eq "/events/#{event.id}"
  end

  scenario 'unsuccessfully, rerenders edit form' do
    fill_in 'Quantity', with: 'Not a number'
    click_button 'Submit'

    expect(page).to have_content "Quantity is not a number"
    expect(page.current_path).to eq "/events/#{event.id}/resources/#{resource.id}"
  end
end
