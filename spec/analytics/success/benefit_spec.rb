# Format: Benefit
#
# Total Entry: 6
# Total Success Direct: 3
# Total Success Logs: 2

require_relative "../../spec_helper"

BENEFIT_LEGAL_AID = {
    :path => "/legal-aid",
    :format => "MS_programme",
    :need_id => "620"
}

describe "benefit success tracking" do
  before(:each) do
    GoogleAnalytics.clear
    visit BENEFIT_LEGAL_AID[:path]
  end

  it "should track an entry event" do
    events = GoogleAnalytics.fetch_events
    events.should have(1).item
    events.should include_entry_for(BENEFIT_LEGAL_AID)
  end

  it "should show the benefit page" do
    current_path.should == BENEFIT_LEGAL_AID[:path]
  end

  it "should allow clicking an internal link" do
    href = find_and_click_link("Eligibility")
    current_path.should == URI.parse(href).path

    # click the first again, this should not cause another success
    href = find_and_click_link("Overview")
    current_path.should == URI.parse(href).path

    events = GoogleAnalytics.fetch_events
    events.should have(2).item
    events.should include_success_for(BENEFIT_LEGAL_AID)
  end

  it "should allow pressing return on an internal link" do
    href = find_and_press_link("Eligibility", 1)
    current_path.should == URI.parse(href).path

    # press the first again, this should not cause another success
    href = find_and_press_link("Overview", 1)
    current_path.should == URI.parse(href).path

    events = GoogleAnalytics.fetch_events
    events.should have(2).item
    events.should include_success_for(BENEFIT_LEGAL_AID)
  end

  it "should allow clicking on an external link" do
    href = find_and_click_link("Scotland")
    current_url.should == href

    events = GoogleAnalytics.fetch_events
    events.should have(1).item
  end

  it "should allow pressing return on an external link" do
    href = find_and_press_link("Scotland", 5)
    current_url.should == href

    events = GoogleAnalytics.fetch_events
    events.should have(1).item
  end

  it "should fire a success after 7 seconds" do
    sleep(7)

    events = GoogleAnalytics.fetch_events
    events.should have(2).item
    events.should include_success_for(BENEFIT_LEGAL_AID)
  end
end