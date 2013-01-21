=begin
  All the module level utility functions are defined here.
=end
module ActAsBuddy

=begin
  This defines the basic getter and setter methods on module level.
=end
  def self.buddy_attr_accessor(*args)
    args.each do |arg|
        self.class_eval("def self.#{arg};@@#{arg};end")
        self.class_eval("def self.#{arg}=(val);@@#{arg}=val;end")
    end
  end
  
  module Util
=begin
  Retrieves the parent class name if using STI.
=end
    def parent_class_name(obj)
      if obj.class.superclass != ActiveRecord::Base
        return obj.class.superclass.name
      end
      return obj.class.name
    end
  end
end