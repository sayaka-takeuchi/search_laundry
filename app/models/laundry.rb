class Laundry < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_many :comments, dependent: :destroy
  has_one_attached :image
  with_options presence: true do
    validates :image
    validates :name
    validates :address
    validates :opening_date
    validates :open_time
    validates :close_time
  end
  with_options inclusion: {in: [true, false]} do
    validates :shoe_washing
    validates :futon_washing
    validates :dryer
    validates :washing_machine
  end

  # def previous
  #   Laundry.where('id<?',self.id).order('opening_date DESC').first
  # end

  # def next
  #   Laundry.where('id>?',self.id).order('id ASC').first
  # end

  def previous
    Laundry.where('opening_date<?',self.opening_date).order('opening_date DESC').first
  end

  def next
    Laundry.where('opening_date>?',self.opening_date).order('opening_date ASC').first
  end
end
