source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.1"
# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 2.6"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Ruby static code analyzer for style enforcement
  gem "rubocop", "~> 1.73", ">= 1.73.1", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # Testing framework for Rails applications
  gem "rspec-rails", "~> 7.1", ">= 7.1.1"

  # FactoryBot for Rails, a library for setting up Ruby objects as test data
  gem "factory_bot_rails", "~> 6.4", ">= 6.4.4"

  # A library for generating fake data such as names, addresses, and more
  gem "faker", "~> 3.5", ">= 3.5.1"

  # Database cleaner for ActiveRecord to ensure a clean state for tests
  gem "database_cleaner-active_record", "~> 2.2"

  # Shoulda Matchers for RSpec, providing one-liners to test common Rails functionality
  gem "shoulda-matchers", "~> 6.4"
end

# Devise for flexible and secure user authentication
gem "devise", "~> 4.9"

# JWT (JSON Web Token) implementation for Ruby
gem "jwt", "~> 2.10", ">= 2.10.1"

# Redis client for Ruby, used for caching, background jobs, and more
gem "redis", "~> 5.4"

# ActiveModelSerializers for JSON serialization in Rails
gem "active_model_serializers", "~> 0.10.15"

# bcrypt for secure password hashing
gem "bcrypt", "~> 3.1", ">= 3.1.20"

# Rack middleware for blocking and throttling abusive requests
gem "rack-attack", "~> 6.7"
