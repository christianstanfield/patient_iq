# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

#######################################
# First company
#######################################

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

2.times { FactoryBot.create :user, department: software_department }
4.times { FactoryBot.create :user, department: hardware_department }

#######################################
# Second company
#######################################

alt_company    = FactoryBot.create :company
alt_department = FactoryBot.create :department, company: alt_company
2.times { FactoryBot.create :user, department: alt_department }
2.times { FactoryBot.create :user, :administrator, department: alt_department }
