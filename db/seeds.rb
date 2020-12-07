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

tests = Test.create([
  {title: 'Основы HTML', level: 1, category: categories[0]},
  {title: 'Основы Ruby', level: 1, category: categories[1]},
  {title: 'Продвинутый Ruby', level: 2, category: categories[1]},
  {title: 'Основы Rails', level: 1, category: categories[2]},
  {title: 'Основы JS', level: 1, category: categories[3]},
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

users = User.create([
  {name: 'John Doe'},
  {name: 'James Bond'}
])

PassedTest.create([
  {user: users[0], test: tests[0]},
  {user: users[0], test: tests[1]},
  {user: users[0], test: tests[2]},
  {user: users[0], test: tests[3]},
  {user: users[0], test: tests[4]},
  {user: users[1], test: tests[0]},
  {user: users[1], test: tests[2]},
  {user: users[1], test: tests[3]},
])