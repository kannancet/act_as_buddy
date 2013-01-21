=begin
  This module defines a class a communicate to Railtie and add a middle ware.
=end
require 'act_as_buddy'
require 'rails'

module ActAsBuddy
  class Railtie < Rails::Railtie
    initializer 'act_as_buddy.initialize' do
      ActiveSupport.on_load(:active_record) do
        include ActAsBuddy::Buddeable
      end
    end
  end
end