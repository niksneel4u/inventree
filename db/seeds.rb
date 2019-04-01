# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin_user = User.create!(
  first_name: 'admin',
  last_name: 'admin',
  password:'123123',
  phone_number: 1231231230,
  company_id: 6
)
admin_user.add_role :admin
