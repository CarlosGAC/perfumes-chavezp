class Bill < ApplicationRecord
  belongs_to :client, inverse_of: :bills, optional: true
  belongs_to :perfume, inverse_of: :orders, optional: true
  has_many :payments, inverse_of: :bill
  enum status: [:Pendiente, :Saldada]
end
