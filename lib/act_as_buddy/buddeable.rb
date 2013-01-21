=begin
  This file contains the functions and classes for adding, removing, finding buddies.
  The core logic is implemented here. 
=end
module ActAsBuddy 
  module Buddeable
    def self.included(base)
      base.extend ClassMethods
    end
    
=begin
  Class methods that add the relations to the class on which ac_as_buddy is called.
=end
    module ClassMethods
      def acts_as_buddeable
        has_many :buddy_mappers, :foreign_key => "buddeable_parent_id", :as => :buddeable
        include ActAsBuddy::Buddeable::InstanceMethods
        include ActAsBuddy::Util
      end
    end
    
=begin
  Instance methods on the class on which act_as_buddy is defined are implemented here.
=end
    module InstanceMethods
    
=begin      
  This function is used to add buddies to the given object.
=end
        def add_buddy(*args)
          couple_buddies, child_buddy = check_argument_pattern(*args)
          build_buddy_collection([child_buddy])
          p "#{self.class.to_s}s with id:#{self.id} and #{child_buddy.id} are now buddies."
        end

=begin       
  This function is used to remove buddies to the given object.
=end
        def remove_buddy(*args)
          couple_buddies, child_buddy = check_argument_pattern(*args)
          couple_buddies.map(&:destroy)
          p "#{self.class.to_s}s with id:#{self.id} and #{child_buddy.id} are now buddies."
        end
        
=begin
  This function is used to get all buddies of an object.
=end
        def fetch_all_buddies
          self.class.joins(:buddy_mappers).where("buddy_mappers.buddeable_child_id=?", self.id)
        end

=begin        
  This function is used to destroy all 
=end
        def remove_all_buddies
          BuddyMapper.delete_all("buddeable_parent_id=#{self.id} OR buddeable_child_id=#{self.id} AND buddeable_type='#{self.class.to_s}'")
        end
        
=begin        
  This function is used to add bulk number of buddies. 
=end  
        def add_multiple_buddies(*args)
          if args.blank? 
            raise "Argument empty!Add buddy needs an argument of same type which invokes the method."
            return
          end
          buddy_collection = args.first
          if buddy_collection.collect(&:id).include?(self.id)
            raise "Loop association error! Cannot associate a record to itself."
            return
          end
          unless buddy_collection.is_a?(Array) || (buddy_collection.select{|elmnt| elmnt.class != self.class}).blank?
            raise "Argument type mismatch! Argument should be an array of objects of same type and of the type same class which invokes the function."
            return
          end
          build_buddy_collection(buddy_collection)
        end
        
=begin        
  This function is used to delete bulk number of buddies. 
=end  
        def remove_multiple_buddies(*args)
          if args.blank? 
            raise "Argument empty!Add buddy needs an argument of same type which invokes the method."
            return
          end
          buddy_collection = args.first
          if buddy_collection.collect(&:id).include?(self.id)
            raise "Loop association error! Cannot associate a record to itself."
            return
          end
          unless buddy_collection.is_a?(Array) || (buddy_collection.select{|elmnt| elmnt.class != self.class}).blank?
            raise "Argument type mismatch! Argument should be an array of objects of same type and of the type same class which invokes the function."
            return
          end
          associated_buddy_mappers = BuddyMapper.where("(buddeable_parent_id=#{self.id} AND buddeable_child_id in (?)) OR ((buddeable_child_id=#{self.id} AND buddeable_parent_id in (?)))", buddy_collection.collect(&:id), buddy_collection.collect(&:id))
          associated_buddy_mappers.destroy_all
        end
        
=begin
  This function is used to find the buddies of a parent by conditions. 
=end
        def find_buddies_with(params = {})
          (raise "Argument cannot be blank." and return) if params.empty?
          (raise "Argument needs to be a hash." and return) unless params.is_a?(Hash)
          self.class.joins(:buddy_mappers).where("buddy_mappers.buddeable_child_id=? AND #{self.class.table_name}.#{params.keys.first.to_s}=?", self.id, params.values.first.to_s)
        end
        
=begin
  This function is used to find the buddies of a parent by with like conditions. 
=end
        def find_buddies_like(params = {})
          (raise "Argument cannot be blank." and return) if params.empty?
          (raise "Argument needs to be a hash." and return) unless params.is_a?(Hash)
          self.class.joins(:buddy_mappers).where("buddy_mappers.buddeable_child_id=? AND #{self.class.table_name}.#{params.keys.first.to_s} like ?", self.id, "%#{params.values.first.to_s}%")
        end
        
=begin
  This function is used to test if two objects are buddied to each other. 
=end
        def is_a_buddy_of?(*args)
          if args.blank?
            raise "Argument empty!Add buddy needs an argument of same type which invokes the method."
            return
          end
          child_buddy = args.first
          unless child_buddy.is_a?(Object)
            raise "Argument mismatch! Argument needs to be an Object."
            return
          end
          check_buddy = BuddyMapper.where("(buddeable_parent_id=#{self.id} AND buddeable_child_id=#{child_buddy.id}) OR (buddeable_parent_id=#{child_buddy.id} AND buddeable_child_id=#{self.id})")          
          check_buddy.blank? ? false : true
        end
       
=begin
  Private functions begin here. 
=end        
        private

=begin        
  This function is used to check the argument type and render errors.
=end
        def check_argument_pattern(*args)
          if args.blank?
            raise "Argument empty!Add buddy needs an argument of same type which invokes the method."
            return
          end
          child_buddy = args.first
          unless child_buddy.is_a?(Object)
            raise "Argument mismatch! Argument needs to be an Object."
            return
          end
          if child_buddy.class != self.class
            raise "Argument mismatch! Buddy can associate only objects of same type."
            return
          end
          if child_buddy.id == self.id
            raise "Loop association error! Cannot associate a record to itself."
            return
          end
          couple_buddies = find_couple_buddies(child_buddy)
          unless couple_buddies.blank?
             if caller[0].include? "add_buddy"
                raise "This buddy is already associated."                 
                return
             end
          else
             if caller[0].include? "remove_buddy"
                raise "These buddies are not associated yet."                 
                return
             end
          end 
          return couple_buddies, child_buddy
        end
        
=begin        
  This function is used to find the couple buddies given two records.
=end
        def find_couple_buddies(child_buddy)
          BuddyMapper.where("(buddeable_child_id=? AND  buddeable_parent_id=?) OR (buddeable_child_id=? AND  buddeable_parent_id=?) AND buddeable_type=?", child_buddy.id, self.id, self.id, child_buddy.id, self.class.to_s)
        end

=begin        
  This function is used to build the buddy records.
  This function accepts a acollection of buddies and builds the records.
=end        
        def build_buddy_collection(*args)
          buddy_collection = args.first
          buddy_collection.each do |buddy|
            parent, child  = self.id, buddy.id
            BuddyMapper.transaction do
              2.times do 
                BuddyMapper.create(:buddeable_parent_id => parent,
                                   :buddeable_child_id => child,
                                   :buddeable_type => self.class.to_s)
                parent, child  = child, parent
              end
            end
          end          
        end
        
    end
  end
end