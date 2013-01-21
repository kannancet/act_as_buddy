class ActAsBuddyMigration < ActiveRecord::Migration
  def self.up
    create_table :buddy_mappers, :force => true do |t|
      t.string :buddeable_type
      t.integer :buddeable_parent_id
      t.integer :buddeable_child_id
      t.timestamps
    end

    add_index :buddy_mappers, ["buddeable_parent_id"], :name => "index_buddeable_parent"
    add_index :buddy_mappers, ["buddeable_child_id"], :name => "index_buddeable_child"
  end

  def self.down
    drop_table :buddy_mappers
  end
end
