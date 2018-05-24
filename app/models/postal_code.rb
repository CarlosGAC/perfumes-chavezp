require 'csv'

class PostalCode < ApplicationRecord

  # Class Method that imports the Jalisco.csv postal codes
  # to the PostalCode table
  def self.importcp
    # Declares an empty array
    postalcodes = []
    # For each row on the csv file, converts it to a hash and adds it to the array
    CSV.foreach("#{Rails.root}/app/assets/Jalisco.csv", headers: true, skip_blanks: true, encoding: "ISO8859-1:utf-8") do |row|
      rowh = row.to_h
      postalcodes << PostalCode.new(rowh)
    end
    # Imports all the hash rows in one single query
    PostalCode.import(postalcodes)
  end

end
