class Category < ApplicationRecord
  has_many :ceramiques

  extend Mobility
  translates :name, type: :string

  validates :name, presence: true, uniqueness: true
end
