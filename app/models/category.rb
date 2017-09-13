class Category < ApplicationRecord
  has_many :ceramiques

  validates :name, presence: true, uniqueness: true
end
