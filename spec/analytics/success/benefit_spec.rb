# Format: Benefit
#
# Total Entry: 6
# Total Success Direct: 3
# Total Success Logs: 2

require_relative "../../spec_helper"
require "uri"

BENEFIT_PATH = "/legal-aid"

describe "benefit success tracking" do
  before(:each) do
    visit BENEFIT_PATH
    dismiss_popup
  end
  it "should show the benefit page" do
    current_path.should == BENEFIT_PATH
  end

  it "should allow clicking an internal link" do
    href = find_and_click_link("Eligibility")
    current_path.should == URI.parse(href).path

    # click the first again, this should not cause another success
    href = find_and_click_link("Overview")
    current_path.should == URI.parse(href).path
  end

  it "should allow pressing return on an internal link" do
    href = find_and_press_link("Eligibility", 1)
    current_path.should == URI.parse(href).path

    # press the first again, this should not cause another success
    href = find_and_press_link("Overview", 1)
    current_path.should == URI.parse(href).path
  end

  it "should allow clicking on an external link" do
    href = find_and_click_link("Scotland")
    current_url.should == href
  end

  it "should allow pressing return on an external link" do
    href = find_and_press_link("Scotland", 5)
    current_url.should == href
  end

  it "should fire a success after 7 seconds" do
    sleep(7)
  end
end