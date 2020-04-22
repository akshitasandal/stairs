ActiveRecord::Base.connection.execute("TRUNCATE roles")
puts "Seeding users"
User.create!([
  {first_name: 'Rajat',
  	last_name: 'Verma',
  	username: 'rajatverma-me',
  	role_id: '1',
  	email: 'rajatverma.me@gmail.com',
  	password: 'admin123',
  },
  {
    first_name: 'Akshita',
    last_name: 'sandal',
    username: 'akshitasandal',
    role_id: '2',
    email: 'akshita@uimatic.com',
    password: 'admin123',
  },
  {
  	first_name: 'Zafar',
  	last_name: 'Ahmed',
  	username: 'zafarahmed',
  	role_id: '3',
  	email: 'zafar@uimatic.com',
  	password: 'admin123',
  },
  {
    first_name: 'Raj',
    last_name: 'Verma',
    username: 'rajverma',
    role_id: '4',
    email: 'raj@uimatic.com',
    password: 'admin123',
  }
  
])