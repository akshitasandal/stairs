ActiveRecord::Base.connection.execute("TRUNCATE roles")
puts "Seeding roles"
Role.create!([
  {name: 'super_admin'},
  {name: 'manager'},
  {name: 'admin'},
  {name: 'user'},
])


