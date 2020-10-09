class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :laundry
  validates :text, presence: true
end
