ActiveRecord::Base.connection.execute("TRUNCATE notification_types")
puts "Seeding Notification Types"
NotificationType.create!([
  {
    name: 'blog_post',
    label: "Someone creates a blog post."
  },
  {
    name: 'follow',
    label: "Someone followed you."
  },
  {
    name: 'bookmark',
    label: "Someone bookmarked your company."
  },
  {
    name: 'subscribe',
    label: "Someone subscribed your company."
  },
   {
    name: 'comment',
    label: "Someone commented on your post."
  },
   {
    name: 'weekly_newsletter',
    label: "Weekly newsletter has been sent."
  },
  
])


