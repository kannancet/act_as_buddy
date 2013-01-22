
 #Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
ActiveRecord::Migration.verbose = false


require File.dirname(__FILE__) + '/../lib/generators/templates/model.rb'

require 'shoulda'