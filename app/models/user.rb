# frozen_string_literal: true

# User model
class User < ApplicationRecord
  enum role: [:user, :moderator, :admin]
  enum user_type: {teacher: 1, student: 2}
  validates :user_type, presence: true

  after_initialize do
    if new_record?
      self.role ||= :user
    end
  end

  has_many :likes
  has_many :comments
  has_many :reports
  has_many :posts, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_many :classworks, dependent: :destroy
  has_many :classrooms, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
end
