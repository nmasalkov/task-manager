class CreateJoinTableUsersTasks < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :tasks do |t|
      t.index [:user_id, :task_id], unique: true
      t.index [:task_id, :user_id], unique: true
    end
  end
end
