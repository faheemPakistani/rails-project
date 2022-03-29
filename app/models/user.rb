# frozen_string_literal: true

# User model
class User < ApplicationRecord
  enum role: [:user, :moderator, :admin]

  after_initialize do
    if new_record?
      self.role ||= :user
    end
  end

  has_many :likes
  has_many :comments
  has_many :reports
  has_many :posts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
end
