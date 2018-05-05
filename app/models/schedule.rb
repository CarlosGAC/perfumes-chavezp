class Schedule < ApplicationRecord
  belongs_to :client, inverse_of: :schedules, optional: true

  validates :place, presence: true, length: { maximum: 50 }, format: { with: /\A[^ ][áéíóúñA-Za-z .]+\z/ }
  # TODO: Fix de editar horario, la ruta no coincide
end
