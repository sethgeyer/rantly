# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.destroy_all

default_user = User.create!(username: "seth",
                   password: "password",
                   first_name: "Seth",
                   last_name: "Geyer",
                   bio: "Handsome Programmer",
                   rant_frequency: "Daily",
                   image: "http://photos1.meetupstatic.com/photos/member/1/2/e/highres_145320302.jpeg",
                   is_admin: false
)


default_admin = User.create!(username: "admin",
                            password: "password",
                            first_name: "Ad",
                            last_name: "Min",
                            bio: "Handsome Programmer",
                            rant_frequency: "Daily",
                            image: "http://photos1.meetupstatic.com/photos/member/1/2/e/highres_145320302.jpeg",
                            is_admin: true
)