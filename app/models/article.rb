class Article < ApplicationRecord
  belongs_to :user

  validates :name, presence: :true

  has_attachment :article_main_photo

  def to_param
    param_title = title.parameterize || ""
    [id, title.parameterize].join("-")
  end
end
