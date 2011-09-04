source 'http://rubygems.org'

gem 'rails', '3.1.0.rc6'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Asset template engines
gem "haml" 
gem 'sass-rails', "~> 3.1.0.rc6"
gem 'coffee-script'
gem 'uglifier'

gem 'jquery-rails'

gem 'cobravsmongoose'
gem 'json'


gem 'pg' 					# postgresql
gem 'activeadmin'
gem "meta_search",    '>= 1.1.0.pre'


group :production do
	gem 'dalli'					# memcached
	gem 'kgio'					# boost to dalli
	gem 'newrelic_rpm'	# new relic
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end
