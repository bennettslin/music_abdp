# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Genre.create(name: 'Hip-hop/Rap')
Genre.create(name: 'Hip+Hop', value: 4)
# Genre.create(name: 'Alternative')
Genre.create(name: 'Alternative+Rock', value: 0)
Genre.create(name: 'Blues', value: 1)
Genre.create(name: 'Classical', value: 2)
Genre.create(name: 'Country', value: 3)
Genre.create(name: 'Singer/Songwriter', value: 8)
Genre.create(name: 'Jazz', value: 5)
Genre.create(name: 'Pop', value: 6)
# Genre.create(name: 'R&B/Soul')
Genre.create(name: 'R&B', value: 7)
Genre.create(name: 'Rock', value: 9)