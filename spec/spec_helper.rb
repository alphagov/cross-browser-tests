require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'rspec'

def target_platform
  ENV["TARGET_PLATFORM"] || "preview"
end

def base_url
  if target_platform == "production"
    "https://www.gov.uk"
  else
    "https://www.#{target_platform}.alphagov.co.uk"
  end
end

RSpec.configure do |config|
  Capybara.default_driver = :selenium
  Capybara.app_host = base_url
  config.include Capybara::DSL
end