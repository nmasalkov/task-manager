# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :tasks
  has_many :comments
  has_many :attachments
  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?
  accepts_nested_attributes_for :tasks

  def set_default_role
    self.role ||= :user
  end

  def username
    email.split('@').first
  end
end
