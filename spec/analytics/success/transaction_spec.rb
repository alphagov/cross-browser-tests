# Format: Transaction
#
# Total Entry: 5
# Total Success Direct: 2
# Total Success Logs: 2

require_relative "../../spec_helper"

APPLY_BLUE_BADGE_TRANSACTION = {
    :path => "/apply-blue-badge",
    :format => "MS_transaction",
    :slug => "apply-blue-badge"
}

describe "transaction success tracking" do
  before(:each) do
    GoogleAnalytics.clear
    visit APPLY_BLUE_BADGE_TRANSACTION[:path]
  end

  it "should track an entry event" do
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
    events.should include_entry_for(APPLY_BLUE_BADGE_TRANSACTION)
  end

  it "should show the transaction page" do
    current_path.should == APPLY_BLUE_BADGE_TRANSACTION[:path]
  end

  it "should allow clicking an internal link" do
    find_and_click_link("your local council")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(APPLY_BLUE_BADGE_TRANSACTION)
  end

  it "should allow clicking an external link" do
    find_and_click_link("Start now")

    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end

  it "should allow pressing return on an internal link" do
    find_and_press_link("your local council")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(APPLY_BLUE_BADGE_TRANSACTION)
  end

  it "should allow pressing return on an external link" do
    find_and_press_link("Track your Blue Badge application.")

    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end
end


