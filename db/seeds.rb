# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# To run your seeds, do:
# rails db:seed


NUM_POSTS = 200
NUM_USERS = 10
PASSWORD = "supersecret"



Comment.delete_all
Post.delete_all
User.delete_all

super_user = User.create(
  name: "Jon Snow",
  email: "js@winterfell.gov",
  password: PASSWORD
  )


  NUM_USERS.times do
    name = Faker::Name.last_name
    User.create(
    name: name,
    email: "#{name.downcase}@example.com",
    password: PASSWORD
    )
    end
    users = User.all


NUM_POSTS.times do
  created_at = Faker::Date.backward(365 * 5)
  p = Post.create(
  
    title: Faker::Hacker.say_something_smart,
    body: Faker::ChuckNorris.fact,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )
  if p.valid?
    p.comments =rand(0..15).times.map do
      Comment.new(
        body: Faker::GreekPhilosophers.quote,
        user: users.sample
      )
    end
  end
end

posts = Post.all
comments = Comment.all

puts Cowsay.say("Generated #{posts.count} posts", :frogs)
puts Cowsay.say("Generated #{comments.count} comments", :tux)
puts Cowsay.say("Generated #{users.count} users", :stegosaurus)
puts "Login with #{super_user.email} and password: #{PASSWORD}"

