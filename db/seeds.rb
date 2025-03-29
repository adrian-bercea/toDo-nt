# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

List.create(name: "To do")
List.create(name: "In progress")
List.create(name: "Done")
List.create(name: "Someday I'll be able to do this")
List.create(name: "Postponed for eternity")


Category.create(name: "Boring")
Category.create(name: "Waste of time")
Category.create(name: "I might do this")


10.times do |i|
  Task.create(
    title: "Task #{i + 1}",
    description: Faker::Lorem.paragraph,
    completed: [ true, false ].sample,
    list_id: 1
  )
end
