source 'http://rubygems.org'

gem 'activerecord', require: 'active_record'
gem 'apartment', '~> 2.2', '>= 2.2.1'
gem 'bcrypt'
gem "rack", ">= 2.0.8"
gem 'pry'
gem 'rack-flash3'
gem 'rake'
gem 'require_all'
gem 'shotgun'
gem 'sinatra'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
group :development do
 gem 'sqlite3'
end

group :production do
 gem 'pg'
end
#gem 'pg', group: :production # Added postgres and made it production only.
gem 'thin'
gem 'tux'
gem 'sinatra-flash'

group :test do
  gem 'capybara'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
  gem 'rack-test'
  gem 'rspec'
end
