# frozen_String_literal: true

# comment model
class Comment < ApplicationRecord
  validates :body, presence: true
  has_rich_text :body
  belongs_to :post
  validates_associated :post
  belongs_to :user
  validates_associated :user
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id
  has_many :likes, as: :likeable
  has_many :reports, as: :reportable

  scope :replies, -> { where(parent_id: nil).includes(:user).order(id: :desc) }
end
