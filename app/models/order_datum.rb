class OrderDatum < ApplicationRecord

  belongs_to :client, inverse_of: :order_data, optional: true
  has_many :orders, inverse_of: :order_datum
end
