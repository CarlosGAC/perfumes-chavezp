class Order < ApplicationRecord

  # An Article belongs to a perfume
  belongs_to :perfume, inverse_of: :orders
  
  # An Article belongs to an order
  belongs_to :order_datum, inverse_of: :orders
  
  # Declares status names for the status field 
  enum status: [:Solicitado, :Procesándose, :Recibido, :Entregado, :Cancelado]

end
