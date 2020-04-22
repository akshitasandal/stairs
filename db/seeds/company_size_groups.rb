ActiveRecord::Base.connection.execute("TRUNCATE company_size_groups")
puts "Seeding Company size Groups"
CompanySizeGroup.create!([
  {size_group: '0-10'},
  {size_group: '10-30'},
  {size_group: '30-50'},
  {size_group: '50-100'},
  {size_group: '100+'},
])