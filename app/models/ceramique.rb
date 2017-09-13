class Ceramique < ApplicationRecord
  belongs_to :category
  has_attachments :photos, maximum: 2, dependent: :destroy
  has_many :basketlines, dependent: :destroy

  monetize :price_cents

  validates :name, presence: true
  validates :stock, presence: true, numericality: { only_integer: true }
  validates :price_cents, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
end
