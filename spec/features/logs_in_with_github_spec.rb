require 'rails_helper'

feature 'user logs in with github' do

  def log_in_with_github
    cookie_jar = Capybara.current_session.driver.browser.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
    cookie_jar[:stub_user_id] = @current_user.id
  end

end
