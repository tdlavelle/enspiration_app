namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Example User",
                 email: "example@example.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all[0..5]
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.questions.create!(content: content) }
    end

    4.times do
      content = Faker::Lorem.sentence(5)
      users[0].questions[0].responses.create!(content: content) 
    end
  end
end