# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

categories = Category.create([
  {title: 'HTML'},
  {title: 'Ruby'},
  {title: 'Rails'},
  {title: 'JavaScript'}
  ])

users = User.create([
  {name: 'John Doe', email: 'john_doe@mail.com'},
  {name: 'James Bond', email: 'james_007@mail.com'},
  {name: 'Admin', email: 'admin@testguru.com'}
  ])

admin = users[2]

tests = Test.create([
  {title: 'Основы HTML', level: 0, category: categories[0], user: admin},
  {title: 'Основы HTML 5', level: 0, category: categories[0], user: admin},
  {title: 'Основы Ruby', level: 2, category: categories[1], user: admin},
  {title: 'Продвинутый Ruby', level: 3, category: categories[1], user: admin},
  {title: 'Основы Rails', level: 7, category: categories[2], user: admin},
  {title: 'Основы JS', level: 5, category: categories[3], user: admin},
  ])

questions = Question.create([
  {body:'Что такое HTML?', test: tests[0]},
  {body:'Что делает тег <br>?', test: tests[0]},
  {body:'Как объявляется глобальная переменная?', test: tests[1]},
  {body:'Как подмешать модуль в класс?', test: tests[2]},
  {body:'Какая команда генерирует каркас приложения?', test: tests[3]},
  {body:'Как правльно обявить переменную?', test: tests[5]},
])

answers = Answer.create([
  {title: 'Язык стилизации элементов на странице', correct: false, question: questions[0]},
  {title: 'Язык гипертекстовой разметки', correct: true, question: questions[0]},
  {title: 'Рисует горизонтальную линию', correct: false, question: questions[1]},
  {title: 'Перенос строки', correct: true, question: questions[1]},
])

TestsUser.create([
  {user: users[0], test: tests[0]},
  {user: users[0], test: tests[1]},
  {user: users[0], test: tests[2]},
  {user: users[0], test: tests[3]},
  {user: users[0], test: tests[4]},
  {user: users[1], test: tests[0]},
  {user: users[1], test: tests[2]},
  {user: users[1], test: tests[3]}
])