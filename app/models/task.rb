# frozen_string_literal: true

class Task < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :comments
  has_many :attachments
  validate :status_valid?

  enum status: {
    waiting_list: 0,
    in_progress: 1,
    done: 2
  }

  def status_valid?
    Task.statuses.include?(status)
  end
end
