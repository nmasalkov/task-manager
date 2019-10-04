class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :assignments
  has_many :tasks, through: :assignments
  has_many :comments
  has_many :attachments
  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?
  accepts_nested_attributes_for :tasks

  scope :created_tasks, -> { assignments where(creator: true) }

  def set_default_role
    self.role ||= :user
  end

  # def created_tasks
  #   assignments.where(creator: true)
  # end

  def username
    email.split('@').first
  end
end
