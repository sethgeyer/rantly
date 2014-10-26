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
                   email: "s.geyer@gmail.com",
                   rant_frequency: "Daily",
                   image: "http://photos1.meetupstatic.com/photos/member/1/2/e/highres_145320302.jpeg",
                   is_admin: false,
                   email_is_confirmed: true

)

second_user = User.create!(username: "adam",
                            password: "password",
                            first_name: "Ada,",
                            last_name: "Geyer",
                            bio: "Handsome Programmer",
                            email: "a.geyer@gmail.com",
                            rant_frequency: "Daily",
                            image: "http://photos1.meetupstatic.com/photos/member/1/2/e/highres_145320302.jpeg",
                            is_admin: false,
                            email_is_confirmed: true

)

third_user = User.create!(username: "leah",
                            password: "password",
                            first_name: "Leah",
                            last_name: "Geyer",
                            bio: "Handsome Programmer",
                            email: "l.geyer@gmail.com",
                            rant_frequency: "Daily",
                            image: "http://blogs.wfmt.com/introductions/files/2011/12/jorie-butler-geyer.jpg",
                            is_admin: false,
                            email_is_confirmed: true

)

default_admin = User.create!(username: "admin",
                            password: "password",
                            first_name: "Ad",
                            last_name: "Min",
                            bio: "Handsome Programmer",
                            email: "admin@gmail.com",
                            rant_frequency: "Daily",
                            image: "http://photos1.meetupstatic.com/photos/member/1/2/e/highres_145320302.jpeg",
                            is_admin: true
)