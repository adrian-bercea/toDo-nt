# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

4
.times do |i|
  List.create(
    name: "List #{i + 1}",
    position: i + 1)
end

Category.create(name: "Boring")
Category.create(name: "Waste of time")
Category.create(name: "I might do this")


10.times do |i|
  Task.create(
    title: "Task #{i + 1}",
    description: Faker::Lorem.paragraph,
    completed: [ true, false ].sample,
    list_id: List.all.sample.id,
    category_ids: Category.all.sample.id,
  )
end
