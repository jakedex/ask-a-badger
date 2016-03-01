# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
pre_a = Preuser.create(phone: "6129404706", status: 1)
pre_b = Preuser.create(phone: "0001112222", status: 0)
pre_c = Preuser.create(phone: "2223334444", status: 2)

# create new question for preuser a, and create corresponding course
q_a = pre_a.questions.new(body: "Lorem ipsum dolor sit amet, mei te dicat copiosae inimicus.
  Agam paulo dissentiet in ius. Ei doming patrioque sadipscing quo. Dolore timeam eligendi
  te eam, mel alii minim intellegebat et, sea no movet ridens noster.", title: "What the fuck is a title?")
q_a.save
c_a = Course.create(title: "CS570")
q_a.course_id = c_a.id
q_a.save

# create new question for preuser b, and create corresponding course
q_b = pre_b.questions.new(body: "Decore timeam iuvaret sit id, sonet omnium
  pertinax nam at. Ea cibo interesset instructior per. Quo illum ridens in, nam
  vide dignissim comprehensam id.", title: "Who do you know here, bro?")
q_b.save
c_b = Course.create(title: "FR101")
q_b.course_id = c_b.id
q_b.save

# create another question by preuser b, for the same course as before
q_b2 = pre_b.questions.new(body: "Ne duo decore aliquam laoreet. Ei cum
  rationibus deseruisse sadipscing, cibo putant ceteros vim ut.", title: "I want candy!")
q_b2.save
q_b2.course_id = c_b.id
q_b2.save

# create new question for preuser b, and create corresponding course
q_c = pre_c.questions.new(body: "Ne vix facer denique fastidii, tation ocurreret
 sea ne. Esse oporteat pro eu. Vim nostrud deterruisset et, ad vis numquam
 vivendo, et nec vocent sanctus voluptaria. Denique luptatum te sea, mei ex
 accusamus vituperatoribus. Unum quas idque sed ea, vide corpora ne sed.",
 title: "Wait - isn't this just Quora all over again?")
q_c.save
c_c = Course.create(title: "CS407")
q_c.course_id = c_c.id
q_c.save

# create new answer for q_c
ans_c = Answer.create(body: "Et justo vivamus sem, consequat diam massa a morbi,
 eros et magna vehicula mauris vivamus, mattis arcu ultricies nam aliquet,
 mauris duis. Facere dignissim mi ut, euismod vitae enim, nam duis.", question_id: q_c.id)
# TODO q/a schema needs some work
q_c.answer_id = ans_c.id
q_c.save
