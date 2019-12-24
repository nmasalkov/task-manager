# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.integer :creator_id
      t.string :creator_name

      t.timestamps
    end
  end
end
