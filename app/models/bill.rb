class Bill < ApplicationRecord
  belongs_to :client, inverse_of: :bills, optional: true
  belongs_to :perfume, inverse_of: :orders, optional: true
  has_many :payments, inverse_of: :bill
  enum status: [:Pendiente, :Saldada]
  
  validates :amount, format: { with: /\A[+]?[0-9]+\z/ }, length: { maximum: 3 }
end
