class AddStatusAndDescriptionToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :integer, default: 0
    add_column :tasks, :description, :text
  end
end
