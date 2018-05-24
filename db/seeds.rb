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
  Client.create(name: name, address: addr, phone_number: pn, external_address_num: exn)
end
