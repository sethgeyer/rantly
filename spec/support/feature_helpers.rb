def create_user(modified_attributes ={})
  default_attributes = {
    username: 'seth',
    password: 'password',
    first_name: 'Seth',
    last_name: 'Geyer',
    bio: 'Handsome Programmer',
    rant_frequency: 'daily',
    image: "http://photos1.meetupstatic.com/photos/member/1/2/e/highres_145320302.jpeg"
  }

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