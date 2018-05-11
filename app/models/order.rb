class Order < ApplicationRecord

  #has_one :perfume, inverse_of: :order
  belongs_to :perfume, inverse_of: :orders
  belongs_to :order_datum, inverse_of: :orders
  enum status: [:Solicitado, :Procesándose, :Recibido, :Entregado, :Cancelado]
end
