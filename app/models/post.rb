# frozen_string_literal: true

# Post
class Post < ApplicationRecord
  enum status: %i[active inactive]

  validates :body, presence: true
  has_rich_text :body
  belongs_to :user
  validates_associated :user
  has_many :comments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :likes, as: :likeable
  has_many :reports, as: :reportable

  after_initialize do
    self.status ||= :inactive if new_record?
  end
end
