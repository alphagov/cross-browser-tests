# Format: Answer
#
# Total Entry: 6
# Total Success Direct: 3
# Total Success Logs: 2

require_relative "../../spec_helper"
require "uri"

ANSWER_PATH = "/electoral-register"

describe "answer success tracking" do
  before(:each) do
    visit ANSWER_PATH
    dismiss_popup
  end

  it "should show the answer page" do
    current_path.should == ANSWER_PATH
  end

  it "should allow clicking an internal link" do
    href = find_and_click_link("your local authority")
    current_path.should == URI.parse(href).path
  end

  it "should allow pressing return on an internal link" do
    href = find_and_press_link("your local authority", 1)
    current_path.should == URI.parse(href).path
  end

  it "should allow clicking on an external link" do
    href = find_and_click_link("Register to vote")
    current_url.should == href
  end

  it "should allow pressing return on an external link" do
    href = find_and_press_link("Register to vote", 5)
    current_url.should == href
  end

  it "should fire a success after 7 seconds" do
    sleep(7)
  end
end