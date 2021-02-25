class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :name, :capacity, :address, :description, :category, :date, :photo, presence: true
  validate :event_date_cannot_be_in_the_past
  validates :category, inclusion: { in: %w(music sports poetry fitness),
    message: "%{value} is not valid" }


  def event_date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
