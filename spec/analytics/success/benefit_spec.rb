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
    events.should have(1).item, "but was #{events.inspect}"
    events.should include_entry_for(BENEFIT_LEGAL_AID)
  end

  it "should show the benefit page" do
    current_path.should == BENEFIT_LEGAL_AID[:path]
  end

  it "should allow clicking an internal link" do
    find_and_click_link("Eligibility")

    # click the first again, this should not cause another success
    find_and_click_link("Overview")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(BENEFIT_LEGAL_AID)
  end

  it "should allow pressing return on an internal link" do
    find_and_press_link("Eligibility")

    # press the first again, this should not cause another success
    find_and_press_link("Overview")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(BENEFIT_LEGAL_AID)
  end

  it "should allow clicking on an external link" do
    find_and_click_link("Scotland")

    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end

  it "should allow pressing return on an external link" do
    find_and_press_link("Scotland")

    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end

  it "should fire a success after 7 seconds" do
    sleep(7)

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(BENEFIT_LEGAL_AID)
  end
end