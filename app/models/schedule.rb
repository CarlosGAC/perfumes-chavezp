class Schedule < ApplicationRecord
  
  # One Schedule belongs to a client
  belongs_to :client, inverse_of: :schedules, optional: true
  
  # Field validations
  validates :place, presence: true, length: { maximum: 50 }, format: { with: /\A[^ ][áéíóúñA-Za-z .]+\z/ }

end
