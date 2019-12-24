# frozen_string_literal: true

Delayed::Worker.queue_attributes = [
  { name: 'renaming', priority: 0 }
]
