class Tag < ApplicationRecord
  has_many :animal_tags, dependent: :destroy
  has_many :animals, through: :animal_tags

  def self.search(params)
    params[:keyword].present? ? where("name like ?", "#{params[:keyword]}%") : Animal.all
  end

  validates :name, presence: true
end
