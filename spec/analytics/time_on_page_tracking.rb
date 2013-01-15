require_relative "../spec_helper"

A_GUIDE = {
    :path => "/transport-disabled"
}

describe "time on page tracking" do
  before(:each) do
    GoogleAnalytics.clear
    visit A_GUIDE[:path]
  end

  it "should fire a single time tracking event after 2 seconds" do
    sleep(2)

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.any? { |event|
      event['event'] == 'TimeSpentOnPage-002'
    }.should be_true
    
  end

  it "should fire two time tracking events after 5 seconds" do
    sleep(5)

    events = GoogleAnalytics.fetch_events
    events.should have(3).item, "but was #{events.inspect}"
    events.any? { |event|
      event['event'] == 'TimeSpentOnPage-002'
    }.should be_true
    events.any? { |event|
      event['event'] == 'TimeSpentOnPage-005'
    }.should be_true
  end
end

