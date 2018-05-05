require 'csv'

class PostalCode < ApplicationRecord
  
  def self.importcp
    postalcodes = []
    CSV.foreach('/Users/carlosga/Documents/GitHub/perfumes-chavez/perfumes/app/assets/Jalisco.csv', headers: true, skip_blanks: true, encoding: "ISO8859-1:utf-8") do |row|
      rowh = row.to_h
      postalcodes << PostalCode.new(rowh)
    end
    PostalCode.import(postalcodes)
  end
  
end