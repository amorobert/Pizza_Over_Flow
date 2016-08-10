#user has name, email, password_hash
6.times do |num|
  name = Faker::StarWars.character
  email = Faker::Internet.email(name)
  text_password = Faker::StarWars.planet
  User.create(name: name, email: email, password: text_password)
end

#question has id, asker_id, title, content
User.each do |user|
  title = Faker::StarWars.quote
  content = Faker::Hipster.paragraph + "?"
  user.questions << Question.new(asker_id: num, title: title, content: content)
end

#answer has question_id, answerer_id, content
User.each do |user|
  content = Faker::Hipster.paragraph
  user.answers << Answer.new(question_id: [1..6].sample, answerer_id: user.id, content: content)
end

#comment has commentable_id, commenter_id, commentable_type, content
User.each do |user|
  3.times do
    content = Faker::StarWars.quote
    user.comments << Comment.new(commentable_id: [1..6].sample, commenter_id: user.id, commentable_type: "question", content: content)
  end
  3.times do
    Faker::StarWars.quote
    user.comments << Comment.new(commentable_id: [1..6].sample, commenter_id: user.id, commentable_type: "answer", content: content)
  end
end

#votes has votable_id, voter_id, votable_type
User.each do |user|
  user.votes << Vote.new([votable_id: 1..6].sample, voter_id: user.id, votable_type: "question")
  user.votes << Vote.new([votable_id: 1..6].sample, voter_id: user.id, votable_type: "answer")
end
