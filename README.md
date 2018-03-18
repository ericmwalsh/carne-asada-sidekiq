# carne-asada-sidekiq

This app, CAS, is a job framework that is used to parse pricing data from the different cryptocurrency exchanges and aggregate them together so that
`carne-asada-api` can act as an API layer on top of the data.  CAS uses [Sidekiq](https://sidekiq.org), [Redis](https://redis.io/), and
[Rails](https://rubyonrails.org) in conjunction with the different data stores and databases on AWS in order to ETL the cryptocurrency pricing data.


## Setup Instructions

I recommend you use [RVM](https://rvm.io/)...The app is using Ruby 2.5.0, I call my gemset `carne-asada`.


Get it from GitHub

* `git clone https://github.com/ericmwalsh/carne-asada-sidekiq.git`
* `cd carne-asada-sidekiq/`


Setup your RVM Gemset
* `rvm gemset create carne-asada`
* `rvm use 2.4.3@carne-asada`


Setup your ENV variables
* `cp .env.sample .env`
* Set the correct values for the dummy variables...


Install bundler and all the other gems
* `gem install bundler`
* `bundle install`


Create the DB and run migrations
* `bundle exec rake db:create db:migrate`


## How to Run the App...

Launch the server in one terminal window
* `bundle exec rails s puma`
* You can navigate to [localhost:3001](http://localhost:3001) in your browser to see Sidekiq's web-ui


Launch the worker process (sidekiq) in another terminal window
* `bundle exec sidekiq`


## How to Run the Tests

Make sure the test environment is configured/up-to-date
* `bundle exec rake db:test:prepare`

Run the test(s) using RSpec
* `bundle exec rspec`


## How to Contribute

Email me at eric@chalupa.io
