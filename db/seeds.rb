# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
perfumes_list = [
  ["Hugo Boss", 700, 1200, 5, 1, 1, 1, 100, 0],
  ["Halloween", 430, 890, 8, 1, 1, 1, 110, 0]
]


perfumes_list.each do |name,bp,rp,stock,pt,classif,cat,pres,visib|
  Perfume.create(name: name, buy_price: bp, retail_price: rp, stock: stock, public_target: pt, classification: classif, category: cat, presentation: pres, visibility: visib)
end

clients_list = [
  ["Carlos Garcia de Alba", "Alberto Cardenas Jimenez","23","341-117-2137"],
  ["Nataly Cruz", "Hacienda del Carmen","635","341-104-6630"]
]

clients_list.each do |name, addr, exn, pn|
  cliente = Client.new(name: name, address: addr, phone_number: pn, external_address_num: exn)
  if cliente.save
    puts "Si jala"
  else
    puts "Valio verga"
  end

end
