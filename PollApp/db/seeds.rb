# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all
u1 = User.create(user_name: "btat")
u2 = User.create(user_name: "sw")
u3 = User.create(user_name: "Obama")
u4 = User.create(user_name: "Trump")
u5 = User.create(user_name: "Putin")


Poll.destroy_all
p1 = Poll.create(title: "Questions", author_id: u4.id)

Question.destroy_all
q1 = Question.create(text: "Should I build the wall?", poll_id: p1.id)
q2 = Question.create(text: "Whats good with health care?", poll_id: p1.id)
q3 = Question.create(text: "What time is it?", poll_id: p1.id)

AnswerChoice.destroy_all
a1 = AnswerChoice.create(text: "Yes", question_id: q1.id )
a2 = AnswerChoice.create(text: "No", question_id: q1.id )
a3 = AnswerChoice.create(text: "Maybe?", question_id: q1.id )

a4 = AnswerChoice.create(text: "Yes", question_id: q2.id )
a5 = AnswerChoice.create(text: "No", question_id: q2.id )
a6 = AnswerChoice.create(text: "Maybe?", question_id: q2.id )

a7 = AnswerChoice.create(text: "Yes", question_id: q3.id )
a8 = AnswerChoice.create(text: "No", question_id: q3.id )
a9 = AnswerChoice.create(text: "Maybe?", question_id: q3.id )

Response.destroy_all
r1 = Response.create(answer_id: a1.id, user_id: u5.id)
r2 = Response.create(answer_id: a2.id, user_id: u3.id)
r3 = Response.create(answer_id: a3.id, user_id: u4.id)
r4 = Response.create(answer_id: a1.id, user_id: u5.id)
