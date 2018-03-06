User.create!(name: 'Simon Reilly', email: 'test@test.com', password: 'asdfasdf', role: 'site_admin')

3.times do |topic|
  Topic.create!(title: "Topic #{topic}")
end

10.times do |blog|
  Blog.create!(
    title: "My blog posts #{blog}",
    body: Forgery(:lorem_ipsum).words(100),
    topic_id: Topic.last.id
  )
end

puts '10 blog posts created'

5.times do |skill|
  Skill.create!(
    title: "Rails #{skill}",
    percent_utilized: 15
  )
end

puts '5 skills created'

8.times do |portfolio_item|
  Portfolio.create!(
    title: "Rails #{portfolio_item}",
    subtitle: "Ruby on Rails",
    body: Forgery(:lorem_ipsum).words(100),
    main_image: 'https://picsum.photos/600/400',
    thumb_image: 'https://picsum.photos/350/200'
  )
end

1.times do |portfolio_item|
  Portfolio.create!(
      title: "Rails #{portfolio_item}",
      subtitle: "Angular",
      body: Forgery(:lorem_ipsum).words(100),
      main_image: 'https://picsum.photos/600/400',
      thumb_image: 'https://picsum.photos/350/200'
  )
end

puts '9 Portfolio items created'


3.times do |technology|
  Portfolio.last.technologies.create!(name: "Technology #{technology}")
end

puts '3 technologies created'