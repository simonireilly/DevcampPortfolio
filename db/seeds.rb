10.times do |blog|
  Blog.create!(
    title: "My blog posts #{blog}",
    body: Forgery(:lorem_ipsum).words(100)
  )
end

puts '10 blog posts created'

5.times do |blog|
  Skill.create!(
    title: "Rails #{blog}",
    percent_utilized: 15
  )
end

puts '5 skills created'

9.times do |portfolio_item|
  Portfolio.create!(
    title: "Rails #{portfolio_item}",
    subtitle: "Rails portfolio item subtitle #{portfolio_item}",
    body: Forgery(:lorem_ipsum).words(100),
    main_image: 'https://picsum.photos/600/400',
    thumb_image: 'https://picsum.photos/350/200'
  )
end



puts '9 Portfolio items created'