class Facility < ApplicationRecord
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  with_options presence: true do
    validates :facility_name
    validates :introduction
    validates :address
  end
  validates :facility_name, length: { maximum: 20 }
  validates :introduction, length: { maximum: 140 }
end
