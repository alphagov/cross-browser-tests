require_relative "spec_helper"

describe "homepage" do
  it "should exist" do
    visit "/"
    page.should have_css('body')
  end
end