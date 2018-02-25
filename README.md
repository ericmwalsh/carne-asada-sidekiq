# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

I recommend you use [RVM](https://rvm.io/)...  Ruby 2.4.3, I call my gemset carne-asada
Get it from GitHub
* `git clone https://github.com/ericmwalsh/carne-asada-sidekiq.git`
* `cd carne-asada-sidekiq/`
Setup your RVM Gemset
* `rvm gemset create carne-asada`
* `rvm use 2.4.3@carne-asada`
Install bundler and all the other gems
* `gem install bundler`
* `bundle install`
Create the DB and run migrations
* `bundle exec rake db:create db:migrate`
Launch the server in one terminal window
* `bundle exec rails s puma`
Launch the worker process (sidekiq) in another terminal window
* `bundle exec sidekiq`
