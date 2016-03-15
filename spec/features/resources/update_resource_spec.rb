require 'rails_helper'

feature 'user updates resource', js: true do
# As a user
# I want to update my list items
# so the list reflects my ever changing needs
#
# Acceptance Criteria
# [x] Every list item will contain an 'Edit' button.
# [x] When clicked, ideally the form appears in the same place as the list item.
# [x] Update will allow you to change quantity only (much like a shopping cart).
# [x] When the form is submitted, ideally the form goes away and is replaced with the newly updated item.

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }
  let!(:inventory_items) do
    [
      FactoryGirl.create(:inventory_item, name: 'SM-58', category: 'Sound'),
      FactoryGirl.create(
        :inventory_item,
        name: 'Source4 50deg 575w',
        category: 'Lighting'
      )
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
    find(:css, ".resource-edit", visible: false).click
      # edit action, name of materails icon is create
  end

  scenario 'successfully' do
    within(first("table")) do
      fill_in "resource-quantity-update#{resource.id}", with: 50
      find(:css, ".resource-update", visible: false).click
    end
    expect(first("table")).to have_content '50'
    expect(first("table")).to_not have_content '4'

    expect(page.current_path).to eq "/events/#{event.id}"
  end

  scenario 'unsuccessfully, rerenders edit form' do
    within(first("table")) do
      fill_in "resource-quantity-update#{resource.id}", with: 'Not a number'
      find(:css, ".resource-update", visible: false).click
    end

    input_value = find(:css, "#resource-quantity-update#{resource.id}").value

    expect(first("table")).to_not have_content '4'
    expect(input_value).to eq 'Not a number'
    expect(page.current_path).to eq "/events/#{event.id}"
  end
end
