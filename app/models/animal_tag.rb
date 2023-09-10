class AnimalTag < ApplicationRecord
  belongs_to :animal
  belongs_to :tag
end
