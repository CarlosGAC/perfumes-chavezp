class Client < ApplicationRecord

  has_many :schedules, inverse_of: :client
  has_many :order_data, inverse_of: :client
  has_many :bills, inverse_of: :client

  accepts_nested_attributes_for :schedules
  accepts_nested_attributes_for :bills

  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[^ ][áéíóúñA-Za-z .]+[^0-9]\z/ }
  validates :external_address_num, length: {maximum: 4}, format: { with: /\A[0-9]+\z/ }
  validates :internal_address_num, length: {maximum: 4}, format: { with: /\A[0-9]+\z/}
  validates :address, length: { maximum: 50 }, format: { with: /\A[^ ][áéíóúñA-Za-z .]+\z/ }
  validates :phone_number, format: { with: /\A([0-9]{3})?[-.●]{1}([0-9]{3})[-.●]{1}([0-9]{4})\z/, message: " debe llevar el formato 000-000-0000" }, length: { is: 12 }
  validates :zipcode, format: { with: /\A[+]?[0-9]+\z/ }, length: { maximum: 5 }
  validates :colony, length: { maximum: 50 }, format: { with: /\A[^ ][0-9áéíóúñA-Za-z .]+\z/ }
  validates :city, length: { maximum: 50 }, format: { with: /\A[^ ][áéíóúñA-Za-z .]+\z/ }
  validates :state, length: { maximum: 50 }, format: { with: /\A[^ ][áéíóúñA-Za-z .]+\z/ }
  # TODO: Revisar las redirecciones y botones de Client
end
