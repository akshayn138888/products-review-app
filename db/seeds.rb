# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Review.delete_all
Tokenizing.delete_all 
Token.delete_all
Product.delete_all
User.delete_all


NUM_PRODUCT = 200
NUM_USER = 10
PASSWORD = 'supersecret'

super_user = User.create(
    first_name: 'jon',
    last_name: 'snow',
    email: 'js@winterfell.gov',
    password: PASSWORD,
    is_admin: true
)
NUM_USER.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: Faker::Internet.email,
        password: PASSWORD
    )
end
users = User.all

#Created Tags here. 
NUM_TOKENS = 20

NUM_TOKENS.times do 
    Token.create(
        name: Faker::Game.genre
    )
end
tokens = Token.all 


NUM_PRODUCT.times do 
    created_at = Faker::Date.backward(days: 365*10)
     p = Product.create(
        title: Faker::Device.model_name,
        description: Faker::Appliance.equipment,
        price:  Faker::Number.within(range: 1..1000),
        user: users.sample,
        created_at: created_at,
        updated_at: created_at     
    )
    if p.valid?
        p.reviews = rand(0..15).times.map do 
            Review.new(
                rating: Faker::Number.between(from: 1.0, to: 5.0),
                body: Faker::Hipster.sentence,
                user: users.sample
            )
        end
        
    end
    p.favouriters = users.shuffle.slice(0, rand(users.count))
    p.tokens = tokens.shuffle.slice(0, rand(tokens.count))   
end


product = Product.all
reviews = Review.all


puts Cowsay.say("Generated #{product.count} products", :cow)
puts Cowsay.say("Generated #{reviews.count} products", :cow)
puts Cowsay.say("Generated #{users.count} products", :cow)
puts Cowsay.say("Generated #{Favourite.count} tokens", :cow)
puts Cowsay.say("Generated #{Token.count} tokens", :cow)