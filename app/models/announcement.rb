class Announcement < ApplicationRecord
  validates :body, presence: true
  has_rich_text :body
  belongs_to :classroom
  validates_associated :classroom
  belongs_to :user
  validates_associated :user
  belongs_to :parent, class_name: 'Announcement', optional: true
  has_many :announcements, foreign_key: :parent_id

  scope :repliess, -> { where(parent_id: nil).includes(:user).order(id: :desc) }

end
