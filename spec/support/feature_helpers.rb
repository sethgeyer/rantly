def create_user_with_a_confirmed_email(modified_attributes ={})
  default_attributes = {
    username: 'seth',
    password: 'password',
    first_name: 'Seth',
    last_name: 'Geyer',
    email: 'seth.geyer@gmail.com',
    bio: 'Handsome Programmer',
    rant_frequency: 'daily',
    email_is_confirmed: true,
    image: "images/profile_photo.JPG"
  }

  attributes = default_attributes.merge(modified_attributes)

  User.create!(attributes)
end


def create_admin_user(modified_attributes = {})
  default_attributes = {
  username: "admin",
  password: "password",
  first_name: "Ad",
  last_name: "Min",
  email: "seth.geyer@gmail.com",
  bio: "My bio",
  rant_frequency: "Daily",
  email_is_confirmed: true,
  image: "/profile_photo.JPG",
  is_admin: true}

  attributes = default_attributes.merge(modified_attributes)

  User.create!(attributes)

end



def create_rant(number = 1, modified_attributes ={})
  default_attributes = {
    topic: "My Pants ##{number}",
    details: "#{"d" * 141}#{number}"
  }

  attributes = default_attributes.merge(modified_attributes)

  Rant.create!(attributes)
end


def create_interesting_ranter(modified_attributes ={})
  default_attributes = {}
  attributes = default_attributes.merge(modified_attributes)
  InterestingRanter.create!(attributes)
end

def create_favorite_rant(user_id, rant_id)
  Favorite.create(user_id: user_id, rant_id: rant_id)
end