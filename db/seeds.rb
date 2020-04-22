# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#Product.delete_all

# NUM_PRODUCT = 1000

# NUM_PRODUCT.times do 
#     created_at = Faker::Date.backward(days: 365*10)
#     Product.create(
#         title: Faker::Device.model_name,
#         description: Faker::Appliance.equipment,
#         price:  Faker::Number.within(range: 1..1000),
#         created_at: created_at,
#         updated_at: created_at
        
#     ) 
# end

# product = Product.all

# puts Cowsay.say("Generated #{product.count} products", :cow)

User.delete_all

NUM_USER = 1000;

NUM_USER.times do
    created_at = Faker::Date.backward(days: 365*5)
    User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        created_at: created_at,
        updated_at: created_at
    )
    
    
end
users= user.all

puts Cowsay.say("Generated #{users.count} users", :cow)
