# Format: Guide
#
# Total Entry: 6
# Total Success Direct: 3
# Total Success Logs: 2

require_relative "../../spec_helper"
require "uri"

GUIDE_PATH = "/transport-disabled"

describe "guide success tracking" do
  before(:each) do
    visit GUIDE_PATH
    dismiss_popup
  end
  it "should show the guide page" do
    current_path.should == GUIDE_PATH
  end

  it "should allow clicking an internal link" do
    href = find_and_click_link("Planes")
    current_path.should == URI.parse(href).path

    # click the first again, this should not cause another success
    href = find_and_click_link("Trains")
    current_path.should == URI.parse(href).path
  end

  it "should allow pressing return on an internal link" do
    href = find_and_press_link("Planes", 1)
    current_path.should == URI.parse(href).path

    # press the first again, this should not cause another success
    href = find_and_press_link("Trains", 1)
    current_path.should == URI.parse(href).path
  end

  it "should allow clicking on an external link" do
    href = find_and_click_link("National Rail")
    current_url.should == href
  end

  it "should allow pressing return on an external link" do
    href = find_and_press_link("National Rail", 5)
    current_url.should == href
  end


  it "should fire a success after 7 seconds" do
    sleep(7)
  end
end