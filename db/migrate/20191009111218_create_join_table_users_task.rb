# frozen_string_literal: true

class CreateJoinTableUsersTask < ActiveRecord::Migration[5.2]
  def change
    create_join_table :tasks, :users do |t|
      t.index %i[task_id user_id]
      t.index %i[user_id task_id]
    end
  end
end
