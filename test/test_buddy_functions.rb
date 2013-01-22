require File.dirname(__FILE__) + '/test_helper'

  class FunctionTest < ActiveSupport::TestCase
    USERS = ['kannan', 'rahul', 'ashik', 'sunil', 'arun', 'jojith']
    
    context "General - "  do
      
        setup do
          BuddyMapper.delete_all
          USERS.collect do |user| 
            created_user = User.find_or_create_by_name(user)
            instance_variable_set('@'+user, created_user)
          end
          @kannan.add_buddy(@sunil)
          @kannan.add_buddy(@ashik)
        end
        
      context "All buddy records" do
    
        should "define act_as_buddy instance methods" do
          assert @kannan.respond_to?(:add_buddy)
          assert @kannan.respond_to?(:remove_buddy)
          assert @kannan.respond_to?(:fetch_all_buddies)
          assert @kannan.respond_to?(:remove_all_buddies)
          assert @kannan.respond_to?(:add_multiple_buddies)
          assert @kannan.respond_to?(:find_buddies_with)
          assert @kannan.respond_to?(:find_buddies_like)
          assert @kannan.respond_to?(:is_a_buddy_of?)
        end
        
      end  
      
      context "Testing add_buddy method - " do
        
        should "return true for correct buddy mapping" do
          assert @kannan.is_a_buddy_of?(@sunil)
          assert @kannan.is_a_buddy_of?(@ashik)
          assert @ashik.is_a_buddy_of?(@kannan)
          assert @sunil.is_a_buddy_of?(@kannan)
        end
        
        should "return false for incorrect buddy mapping" do
          assert "false", @rahul.is_a_buddy_of?(@kannan).to_s
          assert "false", @sunil.is_a_buddy_of?(@ashik).to_s
        end
  
      end
      
      context "Testing fetch_all_buddies - " do
        
        should "return buddy count " do
          assert "2", @kannan.fetch_all_buddies.size.to_s
          assert "1", @sunil.fetch_all_buddies.size.to_s
          assert "1", @ashik.fetch_all_buddies.size.to_s
          assert "0", @rahul.fetch_all_buddies.size.to_s
        end
        
      end
      
      context "Testing add_multiple buddies - " do
        
        setup do
          @kannan.add_multiple_buddies([@jojith, @rahul])
        end
        
        should "return buddy count " do
          assert "4", @kannan.fetch_all_buddies.size.to_s
          assert "1", @jojith.fetch_all_buddies.size.to_s
          assert "1", @rahul.fetch_all_buddies.size.to_s
        end
        
      end
      
      context "Testing remove_multiple_buddies - " do
        
        setup do
          @kannan.remove_multiple_buddies([@jojith, @rahul])
        end
        
        should "return buddy count " do
          assert "2", @kannan.fetch_all_buddies.size.to_s
          assert "0", @jojith.fetch_all_buddies.size.to_s
          assert "0", @rahul.fetch_all_buddies.size.to_s
        end
        
      end
  
      context "Testing find_buddies_with and find_buddies_like- " do
        
        should "return buddy name " do
          assert "sunil", @kannan.find_buddies_with(:name => 'sunil').first.name
          assert "sunil", @kannan.find_buddies_like(:name => 'sun').first.name
        end
        
      end
      
      context "Testing remove_all_buddies - " do
        
        setup do
          @kannan.remove_all_buddies
        end
        
        should "return buddy count " do
          assert "0", @kannan.fetch_all_buddies.size.to_s
          assert "0", @sunil.fetch_all_buddies.size.to_s
          assert "0", @ashik.fetch_all_buddies.size.to_s
        end
        
      end
    
    end
  end
