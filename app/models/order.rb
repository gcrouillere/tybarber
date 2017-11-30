class Order < ApplicationRecord
  monetize :amount_cents
  monetize :port_cents
  has_many :basketlines
  belongs_to :user
  belongs_to :lesson
end
