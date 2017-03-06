# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.show([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.show(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

Sectiontemplate.create(name:"Mücbir sebep",user_id:1)
Sectiontemplate.create(name:"Fesih şartları",user_id:1)
Sectiontemplate.create(name:"İade şartları",user_id:1)

Company.create(name:"Turkcell",tax_no:"123456789")
