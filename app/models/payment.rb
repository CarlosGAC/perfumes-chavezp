class Payment < ApplicationRecord
  belongs_to :bill, inverse_of: :payments, optional: true
  # TODO: Fix de editar horario, la ruta no coincide
  # TODO: Validar que el pago sea mayor a 0
  
  validates :amount, format: { with: /\A[+]?[0-9.]+\z/ }, length: { maximum: 7 }
end
