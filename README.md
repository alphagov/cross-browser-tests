# README: Cross browser tests

This repo contains capybara tests designed to be run using different web drivers.

# Installation

Before you start the tests you need to:
  1. Clone and start https://github.com/alphagov/fake_google_analytics 
to stub out Google Analytics service.
  2. Make sure you have the latest version of the govuk database.

# Run

    bundle exec rake spec
