# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
apple = Company.create! name: 'Apple'
software_department = apple.departments.create! name: 'Software'
hardware_department = apple.departments.create! name: 'Hardware'

software_department.users.create!(
  email:      'sjobs@apple.com',
  password:   'top_secret',
  first_name: 'Steve',
  last_name:  'Jobs',
  phone:      '1234567890',
  address:    '1 Infinite Loop',
  salary:     1_000_000,
  bonus:      1_000_000,
  role:       :administrator
)
software_department.users.create!(
  email:      'tcook@apple.com',
  password:   'top_secret',
  first_name: 'Tim',
  last_name:  'Cook',
  phone:      '1234567890',
  address:    '2 Infinite Loop',
  salary:     1_000_000,
  bonus:      100_000,
  role:       :administrator
)
software_department.users.create!(
  email:      'cintern@apple.com',
  password:   'top_secret',
  first_name: 'College',
  last_name:  'Intern',
  phone:      '1234567890',
  address:    '3 Infinite Loop',
  salary:     10_000,
  bonus:      0,
  role:       :employee
)
