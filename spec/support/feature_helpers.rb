def create_user(modified_attributes ={})
  default_attributes = {
    username: 'seth',
    password: 'password',
    first_name: 'Seth',
    last_name: 'Geyer',
    bio: 'Handsome Programmer',
    rant_frequency: 'daily'
  }

  attributes = default_attributes.merge(modified_attributes)

  User.create!(attributes)
end
