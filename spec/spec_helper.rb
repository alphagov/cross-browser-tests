require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'rspec'
require "uri"
require "net/http"

def browser
  ENV["BROWSER"] || "selenium"
end

def base_url
    "http://www.dev.gov.uk"
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

def find_and_click_link(text)
  anchor = find_link(text)
  href = anchor["href"]
  anchor.click
  href
end

def find_and_press_link(text, sleep_after=1)
  anchor = find_link(text)
  href = anchor["href"]
  anchor.native.send_keys([:return])
  sleep(sleep_after)
  href
end

module GoogleAnalytics
  def self.clear
    request = Net::HTTP::Delete.new('/')
    http.request(request)
  end

  def self.fetch_events
    request = Net::HTTP::Get.new('/events')
    response = http.request(request)

    JSON.parse(response.body)
  end

  private
  def self.http
    Net::HTTP.new("www.google-analytics.com")
  end
end

RSpec::Matchers.define :include_entry_for do |need|
  match do |events|
    events.any? { |event|
      event['event'] == 'Entry' and
          event['format'] == need[:format] and
          event['need_id'] == need[:need_id]
    }
  end
end

RSpec::Matchers.define :include_success_for do |need|
  match do |events|
    events.any? { |event|
      event['event'] == 'Success' and
          event['format'] == need[:format] and
          event['need_id'] == need[:need_id]
    }
  end
end