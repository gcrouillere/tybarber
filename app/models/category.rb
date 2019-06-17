class Category < ApplicationRecord
  has_many :ceramiques
  belongs_to :top_category

  extend Mobility
  translates :name, type: :string, fallbacks: { fr: :en, en: :fr }, locale_accessors: [:en, :fr]

  validates :name, presence: true, uniqueness: true
  validates :top_category, presence: true
end
