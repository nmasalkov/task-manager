# frozen_string_literal: true

class TaskRenamerJob < ApplicationJob
  queue_as :renaming

  def perform(*_args)
    tasks = Task.all
    tasks.each do |task|
      name = Faker::Games::WorldOfWarcraft.hero
      task.update!(title: name)
    end
  end
end
