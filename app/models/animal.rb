class Animal < ApplicationRecord
  belongs_to :user
  has_one_attached :animal_image
end
