class OrderDatum < ApplicationRecord

  # Order belongs to a Client
  belongs_to :client, inverse_of: :order_data, optional: true
  
  # An Order hast many Articles
  has_many :orders, inverse_of: :order_datum
end
