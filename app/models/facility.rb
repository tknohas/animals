class Facility < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :facility_name, presence: true
  validates :introduction, presence: true
  validates :address, presence: true
end
