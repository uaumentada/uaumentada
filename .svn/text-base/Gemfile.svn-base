source 'http://rubygems.org'

gem 'rails', '3.0.10'

gem 'rake', '0.9.2.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'mysql2', '< 0.3'

gem 'geocoder' #To code lat and lng

gem 'speedy_c2dm'#For Android PUSH notifications, https://github.com/sghael/speedy_c2dm

gem "paperclip", "~> 3.0" #image attachments
#requires manually installing:  apt-get install imagemagick

gem 'calendar_date_select', :git => 'https://github.com/paneq/calendar_date_select.git'

gem 'kaminari'


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
    gem 'annotate', '2.4.0'
#   gem 'webrat'
end

group :test do
  gem 'shoulda' #unit testing
  gem 'capybara' #integration testing
end

group :development, :test do
  gem 'factory_girl_rails' 
end

#gem 'gchartrb', :require => "google_chart"  #Google charts
#gem "googlecharts", :require => "gchart"
#gem 'google_charts_on_rails'

