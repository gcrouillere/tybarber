class Article < ApplicationRecord
  belongs_to :user

  validates :name, presence: :true

  has_attachment :article_main_photo

end
