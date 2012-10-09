# Format: Transaction
#
# Total Entry: 5
# Total Success Direct: 2
# Total Success Logs: 2

require_relative "../../spec_helper"
require "uri"

TRANSACTION_PATH = "/apply-blue-badge"

describe "transaction success tracking" do
  before(:each) do
    visit TRANSACTION_PATH
    dismiss_popup
  end

  it "should show the transaction page" do
    current_path.should == TRANSACTION_PATH
  end

  it "should allow clicking an internal link" do
    href = find_and_click_link("your local council")
    current_path.should == URI.parse(href).path
  end

  it "should allow clicking an external link" do
    href = find_and_click_link("Track your Blue Badge application.")
    current_url.should == href
  end

  it "should allow pressing return on an internal link" do
    href = find_and_press_link("your local council")
    # need to wait for browser to catch up
    sleep(1)
    current_path.should == URI.parse(href).path
  end

  it "should allow pressing return on an external link" do
    href = find_and_press_link("Track your Blue Badge application.")
    # need to wait for browser to catch up
    sleep(5)
    current_url.should == href
  end
end