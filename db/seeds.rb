# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create! :username => 'administrator',
                    :email => '9w2pdf@gmail.com',
                    :password => 'password',
                    :password_confirmation => 'password',
                    :admin => '1',
                    :created_at => '2014-09-11 14:14:00',
                    :updated_at => '2014-09-11 14:14:14',
                    :confirmed_at => '2014-09-11 14:14:14',
                    :confirmation_sent_at => '2014-09-11 14:14:00',
                    :sign_in_count => '0'