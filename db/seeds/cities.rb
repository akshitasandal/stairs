ActiveRecord::Base.connection.execute("TRUNCATE cities")
puts "Seeding Cities"
City.create!([
  {name: 'Chandigarh'},
  {name: 'Delhi'},
  {name: 'Mohali'},
  {name: 'Mumbai'},
  {name: 'Kolkata'},
  {name: 'Hyderabad'},
  {name: 'gudgeon'},
])