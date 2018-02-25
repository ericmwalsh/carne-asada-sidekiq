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


git clone

I recommend you use [RVM](rvmurl)...  Ruby 2.4.3, I call my gemset carne-asada

git clone

rvm use 2.4.3@carne-asada
gem install bundler
bundle install
bundle exec rake db:create db:migrate

bundle exec rails s puma
bundle exec sidekiq
