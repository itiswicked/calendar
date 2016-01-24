require 'rails_helper'

feature 'user view resources' do
# As a user
# I want to view resources belonging to a specific event
# so that I know what I need for that event
#
# #### Acceptance Criteria
# [ ] Each event card will have a 'Resources' button, which will lead to the list show page.
# [ ] Items will be group by category (ie lighting, sound).
# [ ] Each list item will have a name and quantity.

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }
  let!(:inventory_items) do
    [
      FactoryGirl.create(:inventory_item, name: "SM-58", category: "Sound"),
      FactoryGirl.create(:inventory_item, name: "Source4 50deg 575w", category: "Lighting")
    ]
  end

  before(:each) do
    login_as(user, scope: :user)
    Resource.create(event: event, inventory_item: inventory_items[0], quantity: 4)
    Resource.create(event: event, inventory_item: inventory_items[1], quantity: 4)
  end

  scenario 'when visit event show page' do
    visit event_path(event)
    event.resources.each do |resource|
      expect(page).to have_content resource.inventory_item.name
    end
  end
end
