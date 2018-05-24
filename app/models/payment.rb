class Payment < ApplicationRecord
  # A Payment belongs to a bill
  belongs_to :bill, inverse_of: :payments, optional: true
  
  # Field validations
  validates :amount, format: { with: /\A[+]?[0-9.]+\z/ }, length: { maximum: 7 }
end
