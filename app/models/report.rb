class Report < ApplicationRecord
  validates :user_id, uniqueness: { scope: [:reportable_id, :reportable_type] }
  belongs_to :user
  belongs_to :reportable, polymorphic: true
end
