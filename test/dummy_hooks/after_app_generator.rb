run "rails g scaffold user name:string"

gsub_file "app/models/user.rb", "end", %(
 act_as_buddeable 

end)
run "rails g model BuddyMapper buddeable_child_id:integer buddeable_parent_id:integer buddeable_type:string"

gsub_file "app/models/buddy_mapper.rb", "end", %(
  include ActiveModel::MassAssignmentSecurity
  attr_accessible :id,
                  :buddeable_child_id,
                  :buddeable_parent_id,
                  :buddeable_type,
                  :created_at,
                  :updated_at
  belongs_to :buddeable, :polymorphic => true

end)
run "rake db:create"
run "rake db:migrate"
