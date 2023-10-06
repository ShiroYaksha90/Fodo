class Recipe < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }
  belongs_to :user
  validates :user_id, presence: true
end
