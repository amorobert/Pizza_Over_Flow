User.delete_all
Question.delete_all
Comment.delete_all
Answer.delete_all
Vote.delete_all
#user has name, email, password_hash
6.times do |num|
  name = Faker::StarWars.character
  email = Faker::Internet.email(name)
  text_password = Faker::StarWars.planet + Faker::StarWars.planet
  params = {name: name, email: email, password: text_password}
  User.create(params)
end

#question has id, asker_id, title, content
User.all.each do |user|
  title = Faker::StarWars.quote
  content = Faker::Hipster.paragraph + "?"
  user.questions << Question.new(asker_id: user.id, title: title, content: content)
end

#answer has question_id, answerer_id, content
User.all.each do |user|
  content = Faker::Hipster.paragraph
  p rand(1..6)
  user.answers << Answer.new(question_id: rand(1..6), answerer_id: user.id, content: content)
end

#comment has commentable_id, commenter_id, commentable_type, content
User.all.each do |user|
  3.times do
    content = Faker::StarWars.quote
    user.comments << Comment.new(commentable_id: rand(1..6), commenter_id: user.id, commentable_type: "question", content: content)
  end
  3.times do
    content = Faker::StarWars.quote
    user.comments << Comment.new(commentable_id: rand(1..6), commenter_id: user.id, commentable_type: "answer", content: content)
  end
end

vote_number  = [-1, 1]
#votes has votable_id, voter_id, votable_type
User.all.each do |user|
  user.votes << Vote.new(votable_id: rand(1..6), voter_id: user.id, votable_type: "question", vote_value: vote_number.sample)
  user.votes << Vote.new(votable_id: rand(1..6), voter_id: user.id, votable_type: "answer", vote_value: vote_number.sample)
end
