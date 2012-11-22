# README: Cross browser tests

This repo contains capybara tests designed to be run using different web drivers.

# Installation

Before you start the tests you need to:
  1. Start Google Analytics stub service
  2. Start GDS applications to be tested.

## 2. Start Google Analytics stub service

Clone [fake google analytics](https://github.com/alphagov/fake_google_analytics) and follow the installation instructions.
This should be running on the same machine that the tests are being run on. If you're running the applications within
a VM and the tests from the host then this should run in the host.

## 3. Start GDS applications to be tested.

Make sure you have a recent copy of the databases for publisher and whitehall.

Start `frontend`, `whitehall` and their dependencies. Note that if you're testing against local changes to `static`
you will need to set the `STATIC_DEV` environment variable for `whitehall`.

```
STATIC_DEV=http://static.dev.gov.uk bowl frontend whitehall
```

# Run

    bundle exec rake spec
