# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :user
  belongs_to :task
end
