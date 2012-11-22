# Format: Policy
#

require_relative "../../spec_helper"

DECENTRALISING_POWER_POLICY = {
    :path => "/government/policies/decentralising-power-through-localism",
    :format => "IG_policy",
    :slug => "decentralising-power-through-localism"
}

COMMUNITIES_TOGETHER_NOT_APART_POLICY = {
    :format => "IG_policy",
    :slug => "decentralising-power-through-localism"
}


describe "policy success tracking" do
  before(:each) do
    GoogleAnalytics.clear
    visit DECENTRALISING_POWER_POLICY[:path]
  end

  it "should track an entry event" do
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
    events.should include_entry_for(DECENTRALISING_POWER_POLICY)
  end

  it "should show the policy page" do
    current_path.should == DECENTRALISING_POWER_POLICY[:path]
  end

  it "should allow clicking an internal link" do
    find_and_click_link("Detail")

    # click the first again, this should not cause another success
    find_and_click_link("Activity")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(DECENTRALISING_POWER_POLICY)
  end

  it "should allow pressing return on an internal link" do
    find_and_press_link("Detail")

    # press the first again, this should not cause another success
    find_and_press_link("Activity")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(DECENTRALISING_POWER_POLICY)
  end

  it "should not track clicking on a fragment link as a sucess" do
    find_and_click_link("The issue")

    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end

  it "should allow clicking on an external link" do
    find_and_click_link("Localism Act 2011")

    # Are not tracked currently
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end

  it "should allow pressing return on an external link" do
    find_and_press_link("Localism Act 2011")

    # Are not tracked currently
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end

  it "should record two consecutive entries to two different policies" do
    find_and_press_link("Activity")
    find_and_press_link("Communities together not apart")

    events = GoogleAnalytics.fetch_events
    events.should have(3).item, "but was #{events.inspect}"
    events.should include_entry_for(DECENTRALISING_POWER_POLICY)
    events.should include_success_for(DECENTRALISING_POWER_POLICY)
    events.should include_entry_for(COMMUNITIES_TOGETHER_NOT_APART_POLICY)
  end

  it "should fire a success after 30 seconds" do
    sleep(30)

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(DECENTRALISING_POWER_POLICY)
  end
end