class TopCategory < ApplicationRecord
  has_many :categories

  has_attachment :photo_1, dependent: :destroy
  has_attachment :photo_2, dependent: :destroy

  extend Mobility
  translates :name, type: :string, fallbacks: { fr: :en, en: :fr }, locale_accessors: [:en, :fr]
  translates :mobile_name, type: :string, fallbacks: { fr: :en, en: :fr }, locale_accessors: [:en, :fr]
  translates :description, type: :string, fallbacks: { fr: :en, en: :fr }, locale_accessors: [:en, :fr]

  validates :name, presence: true, uniqueness: true
  validates :mobile_name, presence: true, uniqueness: true
  validates :photo_1, presence: true
  validates :photo_2, presence: true
end
