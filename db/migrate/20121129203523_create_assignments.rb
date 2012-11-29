class CreateAssignments < ActiveRecord::Migration
  def up
    create_table :assignments do |t|
      t.integer :user_id
      t.integer :role_id
    end
  end

  def down
    drop_table :assignments
  end
end
