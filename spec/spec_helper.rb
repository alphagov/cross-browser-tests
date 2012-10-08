require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'rspec'

def target_platform
  ENV["TARGET_PLATFORM"] || "preview"
end

def user_name
  ENV["USER_NAME"]
end

def password
  ENV["PASSWORD"]
end

def browser
  ENV["BROWSER"] || "selenium"
end

def base_url
  if target_platform == "production"
    "https://www.gov.uk"
  else
    "https://#{user_name}:#{password}@www.#{target_platform}.alphagov.co.uk"
  end
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.register_driver :IE do |app|
  Capybara::Selenium::Driver.new(app, :browser => :ie)
end

RSpec.configure do |config|
  Capybara.default_driver = browser.to_sym
  Capybara.app_host = base_url
  config.include Capybara::DSL
end