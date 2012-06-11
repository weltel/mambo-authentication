# -*- encoding : utf-8 -*-
ENV["RAILS_ENV"] ||= "test"
require "rubygems"
require "bundler"
require "rails"
Bundler.require(:default, :development, :assets) if defined?(Bundler)

$:.push File.expand_path("../lib", __FILE__)
$:.push File.expand_path("../app", __FILE__)

# combustion
Combustion.initialize!(:active_support, :active_record, :action_controller, :action_view, :action_mailer, :sprockets)

spec_path = File.expand_path("../", __FILE__)

# factory girl
require "factory_girl"
Dir[File.join(spec_path, "factories", "**", "*.rb")].each { |f| require f }

# rspec
require "rspec/rails"
Dir[File.join(spec_path, "support", "**", "*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.before(:suite) do
		DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
end
