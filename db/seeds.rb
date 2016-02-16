# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MULTIPLIER = 2

if Rails.env = 'development'
  puts 'Resetting database'

  Rake::Task['db:migrate:reset'].invoke
end

def create_user
  u = User.new
  u.email = Faker::Internet.email
  u.password = 'test'
  u.save!
end

def create_user_profile(user)
  p = Profile.new
  p.user_id = user.id
  p.first_name = Faker::Name.first_name
  p.last_name = Faker::Name.last_name
  p.quote = Faker::Hipster.sentence
  p.about_me = Faker::Hipster.paragraph
  p.day = (1..31).to_a.sample
  p.month = (1..12).to_a.sample
  p.year = (1900..2000).to_a.sample
  p.gender = ['Male', 'Female'].sample
  p.save!
end

def create_user_posts(user)
  p = Post.new
  p.user_id = user.id
  p.body = Faker::Hipster.paragraph
  p.save!
end

def create_post_likes(post)
  users = User.all.sample(MULTIPLIER)
  users.each do |user|
    post.liking_users << user
  end
  post.save!
end

def create_post_comments(post)
  MULTIPLIER.times do
    c = Comment.new
    c.commentable_type = 'Post'
    c.commentable_id = post.id
    c.author_id = User.all.sample.id
    c.body = Faker::Hipster.sentence
    c.save!
  end
end

def create_friends(user)
  friend = User.all.sample
  user.friended_users << friend
  user.save!
end

puts 'Creating test user'
u = User.new
u.email = 'foo@bar.com'
u.password = 'test'
u.save!

puts 'Creating users'

(5 * MULTIPLIER).times do
  create_user
end

puts 'Creating user profiles'

User.all.each do |user|
  create_user_profile(user)
end

puts 'Creating user posts'

User.all.each do |user|
  MULTIPLIER.times { create_user_posts(user) }
end

puts 'Liking posts'

Post.all.each do |post|
  create_post_likes(post)
end

puts 'Commenting on posts'

Post.all.each do |post|
  create_post_comments(post)
end

puts 'Friending users'

User.all.each do |user|
  create_friends(user)
end

puts 'Done!'