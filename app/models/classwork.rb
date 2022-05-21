class Classwork < ApplicationRecord
    enum work_type: [:assignment, :material]
    validates :work_type, presence: true
  
    validates :body, presence: true
    has_rich_text :body
    belongs_to :classroom
    validates_associated :classroom
    belongs_to :user
    validates_associated :user
    belongs_to :parent, class_name: 'Announcement', optional: true
    has_many :announcements, foreign_key: :parent_id
    has_many :submissions, dependent: :destroy

end
