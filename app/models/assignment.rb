class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :task

  scope :created, -> { find_by(creator: true) }
  scope :assigned, -> { where(assigned: true) }

end