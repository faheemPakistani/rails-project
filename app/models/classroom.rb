class Classroom < ApplicationRecord
  has_one_attached :avatar

  belongs_to :user
  validates_associated :user
  has_many :announcements, dependent: :destroy
  has_many :classworks, dependent: :destroy
  has_many :submissions, dependent: :destroy
end
