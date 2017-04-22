User.create(username: 'ian', email: 'email@me.com', password: 'password')
user = User.find_by(:username => 'ian')
user.update(admin: true)
user.save
