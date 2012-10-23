# Format: Guide
#
# Total Entry: 6
# Total Success Direct: 3
# Total Success Logs: 2

require_relative "../../spec_helper"

TRANSPORT_DISABLED_GUIDE = {
    :path => "/transport-disabled",
    :format => "MS_guide",
    :need_id => "1385"
}

describe "guide success tracking" do
  before(:each) do
    GoogleAnalytics.clear
    visit TRANSPORT_DISABLED_GUIDE[:path]
  end

  it "should track an entry event" do
    events = GoogleAnalytics.fetch_events
    events.should have(1).item
    events.should include_entry_for(TRANSPORT_DISABLED_GUIDE)
  end

  it "should show the guide page" do
    current_path.should == TRANSPORT_DISABLED_GUIDE[:path]
  end

  it "should allow clicking an internal link" do
    href = find_and_click_link("Planes")
    current_path.should == URI.parse(href).path

    # click the first again, this should not cause another success
    href = find_and_click_link("Trains")
    current_path.should == URI.parse(href).path

    events = GoogleAnalytics.fetch_events
    events.should have(2).item
    events.should include_success_for(TRANSPORT_DISABLED_GUIDE)
  end

  it "should allow pressing return on an internal link" do
    href = find_and_press_link("Planes", 1)
    current_path.should == URI.parse(href).path

    # press the first again, this should not cause another success
    href = find_and_press_link("Trains", 1)
    current_path.should == URI.parse(href).path

    events = GoogleAnalytics.fetch_events
    events.should have(2).item
    events.should include_success_for(TRANSPORT_DISABLED_GUIDE)
  end

  it "should allow clicking on an external link" do
    href = find_and_click_link("National Rail")
    current_url.should == href

    # Are not tracked currently
    events = GoogleAnalytics.fetch_events
    events.should have(1).item
  end

  it "should allow pressing return on an external link" do
    href = find_and_press_link("National Rail", 5)
    current_url.should == href

    # Are not tracked currently
    events = GoogleAnalytics.fetch_events
    events.should have(1).item
  end

  it "should fire a success after 7 seconds" do
    sleep(7)

    events = GoogleAnalytics.fetch_events
    events.should have(2).item
    events.should include_success_for(TRANSPORT_DISABLED_GUIDE)
  end
end