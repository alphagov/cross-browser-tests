# Format: Detailed guidance
#

require_relative "../../spec_helper"

USING_TRACES_DETAILED_GUIDANCE = {
    :path => "/using-traces-to-trade-in-animals-and-animal-products--3",
    :format => "IG_detailed_guidance",
    :slug => "using-traces-to-trade-in-animals-and-animal-products--3"
}

describe "detailed guidance success tracking" do
  before(:each) do
    GoogleAnalytics.clear
    visit USING_TRACES_DETAILED_GUIDANCE[:path]
  end

  it "should track an entry event" do
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
    events.should include_entry_for(USING_TRACES_DETAILED_GUIDANCE)
  end

  it "should show the detailed guidance page" do
    current_path.should == USING_TRACES_DETAILED_GUIDANCE[:path]
  end

  it "should allow clicking an internal link" do
    find_and_click_link("Introduction")

    # click the first again, this should not cause another success
    find_and_click_link("What TRACES does")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(USING_TRACES_DETAILED_GUIDANCE)
  end

  it "should allow pressing return on an internal link" do
    find_and_click_link("Introduction")

    # press the first again, this should not cause another success
    find_and_click_link("What TRACES does")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(USING_TRACES_DETAILED_GUIDANCE)
  end

  it "should allow clicking on an external link" do
    find_and_click_link("Find details of your local Animal Health office on the Animal Health website")

    # Are not tracked currently
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end

  it "should allow pressing return on an external link" do
    find_and_press_link("Find details of your local Animal Health office on the Animal Health website")

    # Are not tracked currently
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end
end