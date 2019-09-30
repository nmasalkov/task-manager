class Attachment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :task, optional: true
end
