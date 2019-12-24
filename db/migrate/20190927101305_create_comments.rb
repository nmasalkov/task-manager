# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
