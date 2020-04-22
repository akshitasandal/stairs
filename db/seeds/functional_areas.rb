ActiveRecord::Base.connection.execute("TRUNCATE functional_areas")
puts "Seeding functional areas"
FunctionalArea.create!([
  {name: 'Information Technology'},
  {name: 'Human Resources'},
  {name: 'DBA'},
  {name: 'Software Develupment'},
  {name: 'Networking'},

])