class Perfume < ApplicationRecord

  #belongs_to :order, inverse_of: :perfume, optional: true

  has_many :orders, inverse_of: :perfume
  has_many :bills, inverse_of: :perfume
  has_attached_file :picture, styles: { large: "800x800", thumb: "200x200>" }, default_url: "/images/:style/PerfumeNo1.jpg"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  enum public_target: [:Hombre, :Mujer, :Niño, :Niña]
  # TODO: Investigar y colocar las categorias correctas. Brincar a perfume_test.rb
  enum category: [:Toilette, :Parfum]
  enum classification: [:Original, :Fraiche]
  enum visibility: [:Visible, :Invisible]

  # TODO: Validar que los precios sean mayores a 0

  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[^ ][áéíóúñA-Za-z .\#0-9]+\z/ }
  validates :buy_price, format: { with: /\A[+]?[0-9]*\.?[0-9]+\z/ }, length: { maximum: 6 }
  validates :retail_price, format: { with: /\A[+]?[0-9]*\.?[0-9]+\z/ }, length: { maximum: 6 }
  validates :stock, format: { with: /\A[+]?[0-9]+\z/ }, length: { maximum: 4 }
  validates :presentation, format: { with: /\A\d+\z/ }, length: { maximum: 3 }


end
