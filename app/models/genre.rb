class Genre < ApplicationRecord
  has_many :animals
  has_ancestry
end
