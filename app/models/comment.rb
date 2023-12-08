class Comment < ApplicationRecord
  validates :content, presence: true, length: { minimum: 4, maximum: 150 }
  belongs_to :recipe
  belongs_to :user
  validates :user_id, presence: true
  validates :recipe_id, presence: true
  default_scope -> { order(updated_at: :desc) }
end
