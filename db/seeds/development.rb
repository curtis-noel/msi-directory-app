User.delete_all()
(1..10).each do |id|
  User.create!(:username => "user#{id}",
               :email => "user#{id}@test.com",
               :name => "User #{id}",
               :password => 'password',
               :password_confirmation => 'password')
end
