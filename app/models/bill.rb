class Bill < ApplicationRecord
  # Bill belongs to a client
  belongs_to :client, inverse_of: :bills, optional: true
  
  # Perfume belongs to a perfume
  belongs_to :perfume, inverse_of: :orders, optional: true
  
  # Bill has many payments
  has_many :payments, inverse_of: :bill
  
  # Declares enum names to the status field
  enum status: [:Pendiente, :Saldada]
  
  # Field validations
  validates :amount, format: { with: /\A[+]?[0-9]+\z/ }, length: { maximum: 3 }
end
