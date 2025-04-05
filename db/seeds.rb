# db/seeds.rb
user = User.create!(
  email: 'user@example.com',
  password: 'password',
  name: 'Sample User',
  title: 'Video Creator'
)

5.times do |i|
  user.videos.create!(
    title: "Sample Video #{i + 1}",
    description: "This is a sample video description #{i + 1}",
    thumbnail_url: "https://via.placeholder.com/300x200",
    views_count: rand(100..1000),
    shares_count: rand(10..100)
  )
end

puts "Created 1 user with 5 videos"