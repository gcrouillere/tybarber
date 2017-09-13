class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :lessons
  has_many :orders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, format: {with: Regexp.new('\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]{2,}\z'), message:"Adresse email invalide"}
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :adress, presence: true
  validates :zip_code, presence: true, format: {with: Regexp.new('\A(F-)?(((2[A|B])|[0-8]{1}[0-9]{1})|(9{1}[0-5]{1}))[0-9]{3}\z'), message:"Le code postal doit être en France métropolitaine pour les livraisons"}
  validates :city, presence: true

  def display_name
    return self.email
  end
end
