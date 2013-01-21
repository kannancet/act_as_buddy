class BuddyMapper < ActiveRecord::Base
  include ActiveModel::MassAssignmentSecurity
  attr_accessible :id,
                  :buddeable_child_id,
                  :buddeable_parent_id,
                  :buddeable_type,
                  :created_at,
                  :updated_at
  belongs_to :buddeable, :polymorphic => true

end
