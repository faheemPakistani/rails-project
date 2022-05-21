class Submission < ApplicationRecord
    has_one_attached :solution

    belongs_to :user
    validates_associated :user
    belongs_to :classroom
    validates_associated :classroom
    belongs_to :classwork
    validates_associated :classwork

    scope :user, ->(user_id) { User.where(id: user_id) }
end
