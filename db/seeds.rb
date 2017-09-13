Ceramique.destroy_all

names = ["bol", "carafe", "grand plat", "petit plat", "pot de fleur", "saladier", "vasque fleur"]
pictures = ["bol.jpg", "carafe.jpg", "grandplat.jpg", "petitplat.jpg", "potfleur.jpg", "saladier.jpg", "vasquefleur.jpg"]

i = 0
7.times do
  categorie = Category.create(name:"#{names[i]}")
  ceramique = Ceramique.create(
    category: categorie,
    name: names[i],
    description: Faker::Lorem.paragraph(2),
    price: [10, 20, 30, 40, 50].sample,
    stock: 10
  )
  puts "ceramique created"
  puts "app/assets/images/#{pictures[i]}"
  ceramique.photo_urls = ["app/assets/images/#{pictures[i]}"]
  puts "photo attached"
  i += 1
end
