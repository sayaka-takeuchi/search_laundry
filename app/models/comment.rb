class Comment < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :age
  belongs_to_active_hash :rate
  belongs_to :user
  belongs_to :laundry

  with_options presence: true do
    validates :text
    validates :gender

    with_options numericality: { other_than: 0, message: 'を選択してください' } do
      validates :age_id
      validates :rate_id
    end
  end
end
