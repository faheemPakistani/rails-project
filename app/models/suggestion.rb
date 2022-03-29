class Suggestion < ApplicationRecord
  validates :body, presence: true
  belongs_to :post
  belongs_to :user
  validates_associated :user
  belongs_to :parent, class_name: 'Suggestion', optional: true
  has_many :suggestions, foreign_key: :parent_id

  scope :post_suggestions, -> { where(parent_id: nil).includes(:user).order(id: :desc) }
end
