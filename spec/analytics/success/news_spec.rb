# Format: News
#

require_relative "../../spec_helper"

NEWS = {
    :path => "/government/news/250-million-fund-to-herald-return-of-better-weekly-collections",
    :format => "IG_news",
    :slug => "250-million-fund-to-herald-return-of-better-weekly-collections"
}

describe "news success tracking" do
  before(:each) do
    GoogleAnalytics.clear
    visit NEWS[:path]
  end

  it "should track an entry event" do
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
    events.should include_entry_for(NEWS)
  end

  it "should show the news page" do
    current_path.should == NEWS[:path]
  end

  it "should allow clicking an internal link" do
    find_and_click_link("The Rt Hon Eric Pickles MP")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(NEWS)
  end

  it "should allow pressing return on an internal link" do
    find_and_press_link("The Rt Hon Eric Pickles MP")

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(NEWS)
  end

  it "should fire a success after 30 seconds" do
    sleep(30)

    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(NEWS)
  end
end