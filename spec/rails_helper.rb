ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

require 'spec_helper'
require 'rspec/rails'
require 'database_cleaner'
require 'coveralls'
require 'support/factories'

ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :selenium

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) { DatabaseCleaner.clean_with(:truncation) }
  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }

  config.include FactoryGirl::Syntax::Methods
end

include Warden::Test::Helpers
Warden.test_mode!

Coveralls.wear!('rails')
