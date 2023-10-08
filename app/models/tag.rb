class Tag < ApplicationRecord
  has_many :animal_tags, dependent: :destroy
  has_many :animals, through: :animal_tags

  validates :name, presence: true
end
