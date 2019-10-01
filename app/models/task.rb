# frozen_string_literal: true

class Task < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :comments
  has_many :attachments
  validates :title, presence: true
  validate :status_valid?

  enum status: {
    waiting_list: 0,
    in_progress: 1,
    done: 2
  }

  private

  def status_valid?
    Task.statuses.include?(status)
  end
end
