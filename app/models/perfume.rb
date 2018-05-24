class Perfume < ApplicationRecord

  # One Perfume has many orders
  has_many :orders, inverse_of: :perfume
  
  # One Perfume has many bills
  has_many :bills, inverse_of: :perfume
  
  # States the image types with their corresponding sizes, and a default image
  has_attached_file :picture, styles: { large: "800x800", thumb: "200x200>" }, default_url: "/images/:style/PerfumeNo1.jpg"
  
  # Validates that the attachment on the picture field is an image
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  # Declares enum names to fields
  enum public_target: [:Hombre, :Mujer, :Niño, :Niña]
  enum category: [:Toilette, :Parfum]
  enum classification: [:Original, :Fraiche]
  enum visibility: [:Visible, :Invisible]

  # Field validations
  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[^ ][áéíóúñA-Za-z .\#0-9]+\z/ }
  validates :buy_price, format: { with: /\A[+]?[0-9]*\.?[0-9]+\z/ }, length: { maximum: 6 }
  validates :retail_price, format: { with: /\A[+]?[0-9]*\.?[0-9]+\z/ }, length: { maximum: 6 }
  validates :stock, format: { with: /\A[+]?[0-9]+\z/ }, length: { maximum: 4 }
  validates :presentation, format: { with: /\A\d+\z/ }, length: { maximum: 3 }


end
