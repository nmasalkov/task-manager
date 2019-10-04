class Task < ApplicationRecord
  has_many :assignments
  has_many :users, through: :assignments
  has_many :comments
  has_many :attachments
  validates :title, presence: true
  validate :status_valid?

  enum status: {
    waiting_list: 0,
    in_progress: 1,
    done: 2
  }

  def add_creator(user)
    users << user
    assignment = Assignment.find_by(user_id: user.id, task_id: id)
    assignment.creator = true
    assignment.assigned = false
    assignment.save
  end

  def add_assignee(user)
    users << user
    assignment = Assignment.find_by(user_id: user.id, task_id: id)
    assignment.assigned = true
    assignment.save
  end

  def creator
    User.find(assignments.created.user_id)
  end

  def assigned_users
    User.find(assignments.assigned.map(&:user_id))
  end

  def normal_start_date
    normalize_date(start_date)
  end

  def normal_end_date
    normalize_date(end_date)
  end

  private

  def status_valid?
    Task.statuses.include?(status)
  end

  def normalize_date(date)
    date.strftime('%d of %B, %Y, at %I:%M%p')
  end
end
