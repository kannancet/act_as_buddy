=begin
  This will be the base module for act as buddy.
=end
require "act_as_buddy/utils"
module ActAsBuddy
  autoload :Buddeable,   'act_as_buddy/buddeable'
  require "act_as_buddy/railtie" if defined?(Rails) && Rails::VERSION::MAJOR >= 3
end