# Format: Answer
#
# Total Entry: 6
# Total Success Direct: 3
# Total Success Logs: 2

require_relative "../../spec_helper"

CALCULATE_STATE_PENSION = {
    :path => "/calculate-state-pension",
    :format => 'MS_smart_answer',
    :slug => 'calculate-state-pension'
}


describe "answer success tracking" do

  before(:each) do
    Capybara.app_host = "http://smartanswers.dev.gov.uk"
    GoogleAnalytics.clear
    visit CALCULATE_STATE_PENSION[:path]
  end

  it "should track an entry event" do
    events = GoogleAnalytics.fetch_events
    events.should have(1).item, "but was #{events.inspect}"
    events.should include_entry_for(CALCULATE_STATE_PENSION)
  end

  it "should report a success after outcome is reached" do
    find_and_click_link("Start now")

    choose("Calculate your State Pension age and Pension Credit qualifying age")
    find_button("Next step").click

    choose("Male")
    find_button("Next step").click

    select("1", :from => "response_day")
    select("January", :from => "response_month")
    select("1913", :from => "response_year")
    find_button("Next step").click

    find(".outcome")
    sleep(1)
    events = GoogleAnalytics.fetch_events
    events.should have(2).item, "but was #{events.inspect}"
    events.should include_success_for(CALCULATE_STATE_PENSION)
  end
end
