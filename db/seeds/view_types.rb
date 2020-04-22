ActiveRecord::Base.connection.execute("TRUNCATE view_types")
puts "Seeding View Types"
ViewType.create!([
  {name: 'album_view'},
  {name: 'company_view'},
  {name: 'profile_view'},
  {name: 'photo_view'},
  {name: 'post_view'},

])