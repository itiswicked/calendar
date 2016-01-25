require 'rails_helper'

feature 'user deletes resource' do
  # As a user
  # I want to delete an event resource
  # in the event that don't need that list item any more
  #
  # Acceptance Criteria
  # [ ] Every list item will contain a 'Delete' button.
  # [ ] When clicked, the list item ideally disappears without a page refresh.

  scenario 'successfully' do
    user = FactoryGirl.create(:user)
    resource = FactoryGirl.create(:resource)
    name = resource.inventory_item.name
    login_as(user, scope: :user)
    visit event_path(resource.event)

    within(".resource") do |partial_page|
      click_link 'Delete'
      expect(partial_page).to_not have_content name
    end
  end
end
