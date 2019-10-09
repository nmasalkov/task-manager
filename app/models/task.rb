class Task < ApplicationRecord
  has_many :assignments
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

  def creator
    User.find(creator_id)
  end

  def normal_start_date
    normalize_date(start_date)
  end

  def normal_end_date
    normalize_date(end_date)
  end

  def set_creator(user)
    self.creator_id = user.id
    self.creator_name = user.username
  end

  private

  def status_valid?
    Task.statuses.include?(status)
  end

  def normalize_date(date)
    date.strftime('%d of %B, %Y, at %I:%M%p')
  end
end
