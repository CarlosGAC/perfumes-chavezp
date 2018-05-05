class Payment < ApplicationRecord
  belongs_to :bill, inverse_of: :payments, optional: true
  # TODO: Fix de editar horario, la ruta no coincide
  # TODO: Validar que el pago sea mayor a 0
end
