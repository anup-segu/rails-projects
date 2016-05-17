# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |i|
  User.create(username: Faker::Internet.user_name, password: '123123')

  5.times do
    Comment.create(
      body: Faker::StarWars.quote,
      commentable_type: "User",
      commentable_id: i+1,
      user_id: rand(1..100)
    )
  end
end



200.times do |i|
  Goal.create(
    user_id: rand(1..100),
    title: Faker::Hipster.word,
    progress: Goal::STATUS.sample,
    private: [true, false].sample
  )

  5.times do
    Comment.create(
      body: Faker::Hipster.sentence,
      commentable_type: "Goal",
      commentable_id: i+1,
      user_id: rand(1..100)
    )
  end


end
