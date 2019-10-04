class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|
      t.belongs_to :user
      t.belongs_to :task
      t.boolean :creator, default: false
      t.boolean :assigned, default: true
    end
  end
end
