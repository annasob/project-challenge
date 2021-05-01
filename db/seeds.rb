# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dogs = [
  {
    name: 'Bowie',
    description: 'Bowie dances when he walks',
    owner_id: 1
  },
  {
    name: 'Brownie',
    description: 'Brownie only sits pretty',
    owner_id: 1
  },
  {
    name: 'Jax',
    description: '',
    owner_id: 1
  },
  {
    name: 'Jiro',
    description: 'Jiro takes a long time to destroy his toys',
    owner_id: 1
  },
  {
    name: 'Pete',
    description: 'Pete has a best friend named Lua',
    owner_id: 1
  },
  {
    name: 'Bijou',
    description: 'Bijou is the fluffiest of them all',
    owner_id: 2
  },
    {
    name: 'Britta',
    description: 'Britta has two different colored eyes',
    owner_id: 2
  },
  {
    name: 'Noodle',
    description: 'Noodle is an Instagram celebrity',
    owner_id: 2
  },
  {
    name: 'Stella',
    description: 'Stella loves to dig',
    owner_id: 2
  },
  {
    name: 'Tonks',
    description: 'Tonks loves to run',
    owner_id: 2
  },
]

users = [
  {
    name: 'Tom Jones',
    email: 'tom@gmail.com',
    id: 1,
    password: 'tomjones'
  },
  {
    name: 'Bob Marley',
    email: 'bob@gmail.com',
    id: 2,
    password: 'bobmarley'
  },
]

users.each do |user|
  User.find_or_create_by(email: user[:email]) do |u|
    u.name = user[:name],
    u.password = user[:password],
    u.password_confirmation =  user[:password]
  end
end

dogs.each do |dog|
  dog = Dog.find_or_create_by!(name: dog[:name], description: dog[:description], owner_id: dog[:owner_id])
  directory_name = File.join(Rails.root, 'db', 'seed', "#{dog[:name].downcase}", "*")

  Dir.glob(directory_name).each do |filename|
    if !dog.images.any?{|i| i.filename == filename}
      dog.images.attach(io: File.open(filename), filename: filename.split("/").pop)
      sleep 1
    end
  end
end


