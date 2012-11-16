# Format: Answer
#
# Total Entry: 6
# Total Success Direct: 3
# Total Success Logs: 2

require_relative "../../spec_helper"

ELECTORAL_ANSWER = {
    :path => "/electoral-register",
    :format => 'MS_answer',
    :slug => 'electoral-register'
}

LOCAL_AUTHORITY_TRANSACTION = {
    :format => 'MS_transaction',
    :slug => 'register-to-vote'
}


describe "answer success tracking" do
  before(:each) do
    GoogleAnalytics.clear
    visit ELECTORAL_ANSWER[:path]
  end

  it "should track an entry event" do
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
    events.should include_entry_for(ELECTORAL_ANSWER)
  end

  it "should show the answer page" do
    current_path.should == ELECTORAL_ANSWER[:path]
  end

  it "should allow clicking an internal link" do
    find_and_click_link("your local authority")

    events = GoogleAnalytics.fetch_events
    events.should have(3).item, "but was #{events.inspect}"
    events.should include_entry_for(LOCAL_AUTHORITY_TRANSACTION)
    events.should include_success_for(ELECTORAL_ANSWER)
  end

  it "should allow pressing return on an internal link" do
    find_and_press_link("your local authority")

    events = GoogleAnalytics.fetch_events
    events.should have(3).item, "but was #{events.inspect}"
    events.should include_entry_for(LOCAL_AUTHORITY_TRANSACTION)
    events.should include_success_for(ELECTORAL_ANSWER)
  end

  it "should allow clicking on an external link" do
    find_and_click_link("Register to vote")

    # Are not tracked currently
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end

  it "should allow pressing return on an external link" do
    find_and_press_link("Register to vote")

    # Are not tracked currently
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
  end

  it "should fire a success after 7 seconds" do
    sleep(7)

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(ELECTORAL_ANSWER)
  end
end